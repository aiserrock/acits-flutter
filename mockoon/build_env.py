#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Собирает валидный Mockoon environment (schema v3+) из _bodies.json.

Данные двух организаций разделяются по заголовку `x-current-shelter`:
для каждого shelter-зависимого маршрута есть вариант ответа с правилом
по значению заголовка; default-вариант — приют 1.
"""
import json, hashlib, os

_HERE = os.path.dirname(os.path.abspath(__file__))
DATA = json.load(open(os.path.join(_HERE, "_bodies.json")))
G = DATA["global"]
SH = DATA["shelters"]               # {"1": {...}, "2": {...}}
SHELTER_IDS = sorted(SH.keys(), key=int)
DEFAULT_SID = SHELTER_IDS[0]        # "1"

def uid(seed):
    h = hashlib.md5(seed.encode()).hexdigest()
    return f"{h[0:8]}-{h[8:12]}-{h[12:16]}-{h[16:20]}-{h[20:32]}"

def body(obj):
    return json.dumps(obj, ensure_ascii=False, indent=2)

CORS_HEADERS = [
    {"key": "Access-Control-Allow-Origin", "value": "*"},
    {"key": "Access-Control-Allow-Methods", "value": "GET,POST,PUT,PATCH,DELETE,OPTIONS"},
    {"key": "Access-Control-Allow-Headers", "value": "Content-Type,Authorization,x-current-shelter"},
]

def resp(uid_seed, body_str=None, status=200, rules=None, rules_operator="AND",
         default=False, label="", latency=0):
    return {
        "uuid": uid(uid_seed),
        "body": body_str if body_str is not None else "",
        "latency": latency,
        "statusCode": status,
        "label": label,
        "headers": [],
        "bodyType": "INLINE",
        "filePath": "",
        "databucketID": "",
        "sendFileAsBody": False,
        "rules": rules or [],
        "rulesOperator": rules_operator,
        "disableTemplating": False,
        "fallbackTo404": False,
        "default": default,
        "crudKey": "id",
        "callbacks": [],
    }

def id_rule(pid):
    return {"target": "params", "modifier": "id", "value": str(pid), "invert": False, "operator": "equals"}

def shelter_rule(sid):
    # правило по заголовку запроса x-current-shelter
    return {"target": "header", "modifier": "x-current-shelter", "value": f"^{sid}$",
            "invert": False, "operator": "regex"}

def route(seed, method, endpoint, responses, doc=""):
    return {
        "uuid": uid("route-" + seed),
        "type": "http",
        "documentation": doc,
        "method": method,
        # Mockoon сам добавляет ведущий '/' при отображении — в endpoint его
        # быть не должно, иначе в UI виден двойной слэш '//api/...'.
        "endpoint": endpoint.lstrip("/"),
        "responses": responses,
        "responseMode": None,
        "streamingMode": None,
        "streamingInterval": 0,
    }

# ============================================================
#  ОШИБКИ — точные формы боевого бэкенда (Django REST + SimpleJWT).
#  Сняты с dev/prod. Активируются вручную в Mockoon (клик по варианту).
# ============================================================
ERR_401_NO_AUTH   = {"detail": "Authentication credentials were not provided."}
ERR_401_BAD_TOKEN = {"detail": "Given token not valid for any token type", "code": "token_not_valid",
                     "messages": [{"token_class": "AccessToken", "token_type": "access", "message": "Token is invalid or expired"}]}
ERR_401_CREDS     = {"detail": "No active account found with the given credentials"}
ERR_403_SHELTER   = {"detail": "Missing or bad current-shelter."}
ERR_403_FOREIGN   = {"detail": "User admin@acits.ru does not exist in shelter with id 99."}
ERR_404           = {"detail": "Not found."}
ERR_400_LOGIN     = {"username": ["This field is required."], "password": ["This field is required."]}
ERR_400_REFRESH   = {"detail": "Token is invalid or expired", "code": "token_not_valid"}
ERR_400_ANIMAL    = {"spec_id": ["This field is required."], "date_joined": ["This field is required."],
                     "place_of_catch": ["This field is required."], "shelter": ["This field is required."],
                     "animal_attributes": ["This field is required."]}
ERR_400_GENERIC   = {"detail": "Некорректные данные запроса.", "non_field_errors": ["Invalid input."]}
ERR_500           = {"detail": "Внутренняя ошибка сервера."}
ERR_429           = {"detail": "Request was throttled. Expected available in 30 seconds."}
# verify/reset-flow (гостевые ссылки из письма) — статусы из frontend_info_status
ERR_400_INVALID_LINK = {"detail": "Invalid link", "status": "invalid_link"}
ERR_400_BAD_USER     = {"detail": "Bad user", "status": "bad_user"}
ERR_400_BAD_SHELTER  = {"detail": "Bad shelter", "status": "bad_shelter"}
ERR_400_EMAIL        = {"email": ["Enter a valid email address."]}
ERR_400_RESET        = {"new_password": ["This password is too common."], "token": ["Invalid or expired token."]}

def err(seed, status, obj, label):
    """Неактивный по умолчанию error-response — включается вручную в GUI."""
    return resp(f"{seed}-err{status}-{label}", body(obj), status, default=False, label=f"{status} · {label}")

# Наборы ошибок под тип маршрута.
def errors_for(seed, kind):
    """kind: 'auth_login' | 'auth_refresh' | 'protected_get' | 'detail_get'
             | 'create' | 'update' | 'delete' | 'plain'."""
    e = []
    if kind == "auth_login":
        e += [err(seed, 401, ERR_401_CREDS, "неверные креды"),
              err(seed, 400, ERR_400_LOGIN, "поля обязательны"),
              err(seed, 429, ERR_429, "throttled"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "auth_refresh":
        e += [err(seed, 401, ERR_400_REFRESH, "токен истёк"),
              err(seed, 400, ERR_400_LOGIN, "поле refresh обязательно"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "protected_get":
        e += [err(seed, 401, ERR_401_NO_AUTH, "нет токена"),
              err(seed, 401, ERR_401_BAD_TOKEN, "битый токен"),
              err(seed, 403, ERR_403_SHELTER, "нет x-current-shelter"),
              err(seed, 403, ERR_403_FOREIGN, "чужой приют"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "detail_get":
        e += [err(seed, 404, ERR_404, "не найдено"),
              err(seed, 401, ERR_401_BAD_TOKEN, "битый токен"),
              err(seed, 403, ERR_403_SHELTER, "нет x-current-shelter"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "create":
        e += [err(seed, 400, ERR_400_ANIMAL if "animals" in seed else ERR_400_GENERIC, "валидация"),
              err(seed, 401, ERR_401_BAD_TOKEN, "битый токен"),
              err(seed, 403, ERR_403_SHELTER, "нет x-current-shelter"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "update":
        e += [err(seed, 400, ERR_400_GENERIC, "валидация"),
              err(seed, 404, ERR_404, "не найдено"),
              err(seed, 401, ERR_401_BAD_TOKEN, "битый токен"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "delete":
        e += [err(seed, 404, ERR_404, "не найдено"),
              err(seed, 403, ERR_403_SHELTER, "нет x-current-shelter"),
              err(seed, 401, ERR_401_BAD_TOKEN, "битый токен"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "verify_flow":
        # гостевые ссылки email-подтверждения/верификации работника (без токена/приюта)
        e += [err(seed, 400, ERR_400_INVALID_LINK, "invalid_link"),
              err(seed, 400, ERR_400_BAD_USER, "bad_user"),
              err(seed, 400, ERR_400_BAD_SHELTER, "bad_shelter"),
              err(seed, 500, ERR_500, "server error")]
    elif kind == "reset":
        # запрос сброса пароля / подтверждение сброса
        e += [err(seed, 400, ERR_400_EMAIL, "невалидный email"),
              err(seed, 400, ERR_400_RESET, "битый токен/слабый пароль"),
              err(seed, 429, ERR_429, "throttled"),
              err(seed, 500, ERR_500, "server error")]
    else:  # plain
        e += [err(seed, 401, ERR_401_BAD_TOKEN, "битый токен"),
              err(seed, 500, ERR_500, "server error")]
    return e

routes = []

# ---------- ГЛОБАЛЬНЫЕ (не зависят от приюта) ----------
def global_get(seed, endpoint, gkey, doc, err_kind="protected_get"):
    resps = [resp(seed + "-200", body(G[gkey]), 200, default=True, label="OK")]
    resps += errors_for(seed, err_kind)
    routes.append(route(seed, "get", endpoint, resps, doc))

# ---------- ПО ПРИЮТУ (варианты по x-current-shelter) ----------
def shelter_get(seed, endpoint, skey, doc, err_kind="protected_get"):
    """Список/одиночный объект, зависящий от приюта.
    По response с header-правилом на каждый приют + default (копия приюта 1)
    как fallback, когда заголовок не передан/не совпал."""
    responses = []
    for sid in SHELTER_IDS:
        responses.append(resp(
            f"{seed}-sh{sid}", body(SH[sid][skey]), 200,
            rules=[shelter_rule(sid)], label=f"shelter {sid}",
        ))
    # fallback: если x-current-shelter не задан — отдаём приют по умолчанию
    responses.append(resp(
        f"{seed}-default", body(SH[DEFAULT_SID][skey]), 200,
        default=True, label=f"default (shelter {DEFAULT_SID})",
    ))
    responses += errors_for(seed, err_kind)
    routes.append(route(seed, "get", endpoint, responses, doc))

def shelter_detail_get(seed, endpoint, detail_key, doc, err_kind="detail_get"):
    """Detail по :id с учётом приюта: правило (header AND id) на каждый объект,
    default → первый объект приюта 1."""
    responses = []
    for sid in SHELTER_IDS:
        for pid, obj in SH[sid][detail_key].items():
            responses.append(resp(
                f"{seed}-sh{sid}-{pid}", body(obj), 200,
                rules=[shelter_rule(sid), id_rule(pid)], rules_operator="AND",
                label=f"shelter {sid} · id={pid}",
            ))
    any_obj = next(iter(SH[DEFAULT_SID][detail_key].values()))
    responses.append(resp(f"{seed}-default", body(any_obj), 200, default=True, label="default"))
    responses += errors_for(seed, err_kind)
    routes.append(route(seed, "get", endpoint, responses, doc))

def nested_list_get(seed, endpoint, skey, doc, err_kind="protected_get"):
    """Вложенный под животным список (/animals/:animal_pk/<sub>/).
    Данные по животному в моке не фильтруем — отдаём список текущего приюта
    (правило по x-current-shelter) + default(приют 1) fallback."""
    responses = []
    for sid in SHELTER_IDS:
        responses.append(resp(
            f"{seed}-sh{sid}", body(SH[sid][skey]), 200,
            rules=[shelter_rule(sid)], label=f"shelter {sid}",
        ))
    responses.append(resp(
        f"{seed}-default", body(SH[DEFAULT_SID][skey]), 200,
        default=True, label=f"default (shelter {DEFAULT_SID})",
    ))
    responses += errors_for(seed, err_kind)
    routes.append(route(seed, "get", endpoint, responses, doc))

# соответствие HTTP-метода мутации → набор ошибок
_MUT_KIND = {"post": "create", "patch": "update", "put": "update", "delete": "delete"}

def stub(seed, method, endpoint, body_obj, doc, status=200, err_kind=None):
    resps = [resp(f"{seed}-{status}", body(body_obj) if body_obj is not None else "", status, default=True, label="stub")]
    resps += errors_for(seed, err_kind or _MUT_KIND.get(method, "plain"))
    routes.append(route(seed, method, endpoint, resps, doc))

def first_detail(skey):
    return next(iter(SH[DEFAULT_SID][skey].values()))

def nested_detail_get(seed, endpoint, dkey, doc, err_kind="detail_get"):
    """Detail вложенного ресурса (/animals/:animal_pk/<sub>/:id/) с header-правилом
    на приют. По id внутри приюта не разветвляем — данных мало, отдаём первый
    объект приюта; default → приют 1."""
    responses = []
    for sid in SHELTER_IDS:
        vals = SH[sid][dkey]
        obj = next(iter(vals.values())) if vals else {}
        responses.append(resp(f"{seed}-sh{sid}", body(obj), 200,
                              rules=[shelter_rule(sid)], label=f"shelter {sid}"))
    responses.append(resp(f"{seed}-default", body(first_detail(dkey)), 200, default=True, label="default"))
    responses += errors_for(seed, err_kind)
    routes.append(route(seed, "get", endpoint, responses, doc))

# ============================================================
#  МАРШРУТЫ
# ============================================================

# ---------- AUTH ----------
routes.append(route("token", "post", "/api/token/",
    [resp("token-200", body(G["token"]), 200, default=True, label="OK")] + errors_for("token", "auth_login"),
    "JWT login (SimpleJWT). Ошибки: 401 неверные креды, 400 поля, 429, 500."))
routes.append(route("token-refresh", "post", "/api/token/refresh/",
    [resp("token-refresh-200", body(G["token_refresh"]), 200, default=True, label="OK")] + errors_for("token-refresh", "auth_refresh"),
    "JWT refresh. Ошибки: 401 токен истёк, 400, 500."))

# ---------- USER / BOOTSTRAP ----------
global_get("me", "/api/v1/users/me/", "me", "Текущий пользователь", err_kind="plain")
stub("me-patch", "patch", "/api/v1/users/me/", G["me"], "Обновить профиль (stub)")
stub("me-put", "put", "/api/v1/users/me/", G["me"], "Обновить профиль (stub)")
stub("me-change-pass", "patch", "/api/v1/users/me/change_password/", {"detail": "Пароль изменён"}, "Смена пароля (stub)")
global_get("my-shelters", "/api/v1/users/me/shelters/", "my_shelters", "Мои приюты (обе организации)", err_kind="plain")
# current — зависит от выбранного приюта (роль/права)
shelter_get("current-shelter", "/api/v1/users/me/shelters/current/", "current_shelter", "Текущий приют + роль (по x-current-shelter)")
global_get("available-shelters", "/api/v1/available-shelters/", "available_shelters", "Доступные для входа приюты", err_kind="plain")
global_get("available-workers", "/api/v1/users/available-workers/", "available_workers", "Доступные работники")

# ---------- PASSWORD RESET / VERIFY (гостевые ссылки из письма) ----------
# happy-path — пустой 200 / редирект на фронт; ценность в error-вариантах.
stub("reset-password", "post", "/api/v1/users/reset-password/", {"detail": "Письмо со ссылкой отправлено."},
     "Запрос сброса пароля (stub). Ошибки: 400 email, 429, 500.", err_kind="reset")
stub("reset-password-complete", "post", "/api/v1/users/reset-password/complete/", {"detail": "Пароль изменён."},
     "Завершение сброса пароля (stub). Ошибки: 400 битый токен/слабый пароль.", err_kind="reset")
stub("reset-password-confirm", "get", "/api/v1/users/reset-password/confirm/:uidb64/:token/", {"status": "email_verified"},
     "Проверка ссылки сброса (stub). Ошибки: 400 invalid_link/bad_user.", err_kind="verify_flow")
stub("verify-email", "get", "/api/v1/users/verify-email/:uidb64/:sidb64/:token/", {"status": "email_verified"},
     "Подтверждение email (stub). Ошибки: 400 invalid_link/bad_user/bad_shelter.", err_kind="verify_flow")
stub("verify-worker", "get", "/api/v1/users/verify-worker/:uidb64/:sidb64/:token/", {"status": "verified_by_admin"},
     "Подтверждение работника (stub). Ошибки: 400 invalid_link/bad_shelter.", err_kind="verify_flow")

# ---------- SHELTERS ----------
global_get("shelters-list", "/api/v1/shelters/", "my_shelters", "Список приютов (short)")
shelter_get("shelters-detail", "/api/v1/shelters/:id/", "shelter_detail", "Приют — детально (по x-current-shelter)")
stub("shelters-patch", "patch", "/api/v1/shelters/:id/", SH[DEFAULT_SID]["shelter_detail"], "Обновить приют (stub)")

# ---------- ANIMALS ----------
# ВАЖНО: литеральные под-пути (species/attributes/stats/notes) регистрируем
# ДО параметрического /animals/:id/, иначе Mockoon поймает stats как id=stats.
shelter_get("animals-list", "/api/v1/animals/", "animals_list", "Список животных (по x-current-shelter)")
global_get("animals-species-list", "/api/v1/animals/species/", "species_list", "Виды/породы (дерево)", err_kind="plain")
global_get("animals-attributes", "/api/v1/animals/attributes/", "attributes", "Атрибуты животных", err_kind="plain")
shelter_get("animals-stats", "/api/v1/animals/stats/", "stats", "Статистика (по x-current-shelter)")

# ---------- NOTES (под /animals/notes/ — тоже до /animals/:id/) ----------
shelter_get("notes-list", "/api/v1/animals/notes/", "notes_list", "Заметки (по x-current-shelter)")
shelter_detail_get("notes-detail", "/api/v1/animals/notes/:id/", "notes_detail", "Заметка — детально")
stub("notes-post", "post", "/api/v1/animals/notes/", first_detail("notes_detail"), "Создать заметку (stub)", status=201)
stub("notes-patch", "patch", "/api/v1/animals/notes/:id/", first_detail("notes_detail"), "Обновить заметку (stub)")
stub("notes-delete", "delete", "/api/v1/animals/notes/:id/", None, "Удалить заметку (stub)", status=204)

# параметрические маршруты по животному
stub("animals-files", "get", "/api/v1/animals/:id/files/", [], "Файлы животного (stub)")
stub("animals-history", "get", "/api/v1/animals/:id/history/", SH[DEFAULT_SID]["animals_list"], "История животного (stub)")

# ---------- ВЛОЖЕННЫЕ ПОД ЖИВОТНЫМ (adoptions / overstays / releases / restore) ----------
# ВАЖНО: под-пути /animals/:animal_pk/... регистрируем ДО голого /animals/:id/,
# иначе Mockoon поймает animal_pk как :id и деталка перехватит запрос.
nested_list_get("adoptions-list", "/api/v1/animals/:id/adoptions/", "adoptions_list", "Усыновления животного (по x-current-shelter)")
nested_detail_get("adoptions-detail", "/api/v1/animals/:id/adoptions/:id/", "adoptions_detail", "Усыновление — детально")
stub("adoptions-post", "post", "/api/v1/animals/:id/adoptions/", first_detail("adoptions_detail"), "Создать усыновление (stub)", status=201)
stub("adoptions-put", "put", "/api/v1/animals/:id/adoptions/:id/", first_detail("adoptions_detail"), "Обновить усыновление (stub)")
stub("adoptions-patch", "patch", "/api/v1/animals/:id/adoptions/:id/", first_detail("adoptions_detail"), "Обновить усыновление (stub)")

nested_list_get("overstays-list", "/api/v1/animals/:id/overstays/", "overstays_list", "Передержки животного (по x-current-shelter)")
nested_detail_get("overstays-detail", "/api/v1/animals/:id/overstays/:id/", "overstays_detail", "Передержка — детально")
stub("overstays-post", "post", "/api/v1/animals/:id/overstays/", first_detail("overstays_detail"), "Создать передержку (stub)", status=201)
stub("overstays-put", "put", "/api/v1/animals/:id/overstays/:id/", first_detail("overstays_detail"), "Обновить передержку (stub)")
stub("overstays-patch", "patch", "/api/v1/animals/:id/overstays/:id/", first_detail("overstays_detail"), "Обновить передержку (stub)")

nested_list_get("releases-list", "/api/v1/animals/:id/releases/", "releases_list", "Выпуски животного (по x-current-shelter)")
nested_detail_get("releases-detail", "/api/v1/animals/:id/releases/:id/", "releases_detail", "Выпуск — детально")
stub("releases-post", "post", "/api/v1/animals/:id/releases/", first_detail("releases_detail"), "Создать выпуск (stub)", status=201)
stub("releases-put", "put", "/api/v1/animals/:id/releases/:id/", first_detail("releases_detail"), "Обновить выпуск (stub)")
stub("releases-patch", "patch", "/api/v1/animals/:id/releases/:id/", first_detail("releases_detail"), "Обновить выпуск (stub)")

stub("animals-restore", "put", "/api/v1/animals/:id/restore/", {"status": "IN_THE_SHELTER"}, "Восстановить животное (stub)")

shelter_detail_get("animals-detail", "/api/v1/animals/:id/", "animals_detail", "Животное — детально (по x-current-shelter)")
stub("animals-post", "post", "/api/v1/animals/", first_detail("animals_detail"), "Создать животное (stub)", status=201)
stub("animals-patch", "patch", "/api/v1/animals/:id/", first_detail("animals_detail"), "Обновить животное (stub)")
stub("animals-delete", "delete", "/api/v1/animals/:id/", None, "Удалить животное (stub)", status=204)

# ---------- CURATORS ----------
shelter_get("curators-list", "/api/v1/curators/", "curators_list", "Кураторы (по x-current-shelter)")
shelter_detail_get("curators-detail", "/api/v1/curators/:id/", "curators_detail", "Куратор — детально")
stub("curators-post", "post", "/api/v1/curators/", first_detail("curators_detail"), "Создать куратора (stub)", status=201)
stub("curators-patch", "patch", "/api/v1/curators/:id/", first_detail("curators_detail"), "Обновить куратора (stub)")

# ---------- APPLICANTS ----------
shelter_get("applicants-list", "/api/v1/applicants/", "applicants_list", "Заявители (по x-current-shelter)")
shelter_detail_get("applicants-detail", "/api/v1/applicants/:id/", "applicants_detail", "Заявитель — детально")
stub("applicants-post", "post", "/api/v1/applicants/", first_detail("applicants_detail"), "Создать заявителя (stub)", status=201)
stub("applicants-patch", "patch", "/api/v1/applicants/:id/", first_detail("applicants_detail"), "Обновить заявителя (stub)")
stub("applicants-delete", "delete", "/api/v1/applicants/:id/", None, "Удалить заявителя (stub)", status=204)

# ---------- ADOPTERS ----------
shelter_get("adopters-list", "/api/v1/adopters/", "adopters_list", "Усыновители (по x-current-shelter)")
shelter_detail_get("adopters-detail", "/api/v1/adopters/:id/", "adopters_detail", "Усыновитель — детально")
stub("adopters-post", "post", "/api/v1/adopters/", first_detail("adopters_detail"), "Создать усыновителя (stub)", status=201)

# ---------- ANIMAL SITTERS (передержчики) ----------
shelter_get("sitters-list", "/api/v1/animal_sitters/", "animal_sitters_list", "Передержчики (по x-current-shelter)")
shelter_detail_get("sitters-detail", "/api/v1/animal_sitters/:id/", "animal_sitters_detail", "Передержчик — детально")
stub("sitters-post", "post", "/api/v1/animal_sitters/", first_detail("animal_sitters_detail"), "Создать передержчика (stub)", status=201)
stub("sitters-put", "put", "/api/v1/animal_sitters/:id/", first_detail("animal_sitters_detail"), "Обновить передержчика (stub)")
stub("sitters-patch", "patch", "/api/v1/animal_sitters/:id/", first_detail("animal_sitters_detail"), "Обновить передержчика (stub)")

# ---------- PRESCRIPTIONS ----------
# executions/ — литерал, до параметрического /prescriptions/:id/
shelter_get("prescriptions-list", "/api/v1/prescriptions/", "prescriptions_list", "Назначения (по x-current-shelter)")
shelter_get("prescriptions-exec", "/api/v1/prescriptions/executions/", "prescriptions_executions", "Назначения на сегодня")
shelter_detail_get("prescriptions-detail", "/api/v1/prescriptions/:id/", "prescriptions_detail", "Назначение — детально")
stub("prescriptions-post", "post", "/api/v1/prescriptions/", first_detail("prescriptions_detail"), "Создать назначение (stub)", status=201)
stub("prescriptions-patch", "patch", "/api/v1/prescriptions/:id/", first_detail("prescriptions_detail"), "Обновить назначение (stub)")
stub("prescriptions-delete", "delete", "/api/v1/prescriptions/:id/", None, "Удалить назначение (stub)", status=204)

# ---------- DRUGS ----------
shelter_get("drugs-list", "/api/v1/shelter/drugs/", "drugs_list", "Аптека приюта (по x-current-shelter)")

# ---------- WORKERS ----------
shelter_get("workers-list", "/api/v1/shelter/workers/", "workers_list", "Работники приюта (по x-current-shelter)")
stub("workers-approve", "put", "/api/v1/shelter/workers/:id/approve/", {"detail": "approved"}, "Одобрить работника (stub)")
stub("workers-decline", "put", "/api/v1/shelter/workers/:id/decline/", {"detail": "declined"}, "Отклонить работника (stub)")
stub("workers-delete", "delete", "/api/v1/shelter/workers/:id/", None, "Удалить работника (stub)", status=204)

# ---------- VALUES / FEEDBACK ----------
global_get("values", "/api/v1/values-for-selection/", "values", "Справочники (enum + локализация)", err_kind="plain")
stub("feedback", "post", "/api/v1/feedback/", {"detail": "Спасибо за отзыв!"}, "Обратная связь (stub)", status=201)

# ---------- ENV WRAPPER ----------
env = {
    "uuid": uid("env-acits"),
    "lastMigration": 33,
    "name": "ACITS Mock API",
    "endpointPrefix": "",
    "latency": 0,
    "port": 3000,
    "hostname": "",
    "folders": [],
    "routes": routes,
    "rootChildren": [{"type": "route", "uuid": r["uuid"]} for r in routes],
    "proxyMode": False,
    "proxyHost": "",
    "proxyRemovePrefix": False,
    "tlsOptions": {"enabled": False, "type": "CERT", "pfxPath": "", "certPath": "", "keyPath": "", "caPath": "", "passphrase": ""},
    "cors": True,
    "headers": [
        {"key": "Content-Type", "value": "application/json; charset=utf-8"},
    ] + CORS_HEADERS,
    "proxyReqHeaders": [{"key": "", "value": ""}],
    "proxyResHeaders": [{"key": "", "value": ""}],
    "data": [],
    "callbacks": [],
}

out = os.path.join(_HERE, "mockoon.json")
json.dump(env, open(out, "w"), ensure_ascii=False, indent=2)
print("wrote", out)
print("routes:", len(routes))
