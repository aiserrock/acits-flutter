#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Генератор mockoon/mockoon.json для приложения ACITS.
Строит связный красивый датасет (реальные клички + фото кошек/собак)
и валидный Mockoon environment (schema v3+), точно повторяющий формы
ответов боевого бэкенда app.acits.ru.
"""
import json, hashlib

VALUES_JSON = '{"animal_status": [{"value": "IN_THE_SHELTER", "display_name": "In the shelter"}, {"value": "HOSPITAL", "display_name": "Hospital"}, {"value": "OVEREXPOSURE", "display_name": "Overexposure"}, {"value": "ATTACHED", "display_name": "Attached"}, {"value": "PREPARING_TO_RELEASE", "display_name": "Preparing to release"}, {"value": "RELEASED", "display_name": "Released"}, {"value": "DEATH", "display_name": "Death"}, {"value": "EUTHANASIA", "display_name": "Euthanasia"}, {"value": "IN_CLINIC", "display_name": "In clinic"}], "species_level": [{"value": 1, "display_name": "One"}, {"value": 2, "display_name": "Two"}, {"value": 3, "display_name": "Three"}], "shelters_event_types": [{"value": "INCOME", "display_name": "Income"}, {"value": "OUTCOME", "display_name": "Outcome"}, {"value": "ONCE", "display_name": "Once"}, {"value": "TWICE", "display_name": "Twice"}, {"value": "OTHER_NUMBER_OF_TIMES", "display_name": "Other number of times"}], "prescription_types": [{"value": "COURSE_OF_TREATMENT", "display_name": "Course of treatment"}, {"value": "APPOINTMENT", "display_name": "Appointment"}, {"value": "READMISSION", "display_name": "Readmission"}, {"value": "REMOVING_STITCHES", "display_name": "Removing stitches"}, {"value": "WOUND_HEALING", "display_name": "Wound healing"}, {"value": "ANALYSIS", "display_name": "Analysis"}, {"value": "PARASITES_TREATMENT", "display_name": "Parasites Treatment"}, {"value": "VACCINATION", "display_name": "Vaccination"}, {"value": "OTHER", "display_name": "Other"}], "parasites_types": [{"value": "ENDOPARASITES", "display_name": "Endoparasites"}, {"value": "ECTOPARASITES", "display_name": "Ectoparasites"}], "prescription_duration_types": [{"value": "EVERYDAY", "display_name": "Everyday"}, {"value": "EVERY_WEEK", "display_name": "Every week"}, {"value": "CUSTOM", "display_name": "Custom"}], "translate_duration_procedures_types": [{"value": "ONCE", "display_name": "Once"}, {"value": "TWICE", "display_name": "Twice"}], "prescription_execution_status": [{"value": "IN_PROGRESS", "display_name": "In progress"}, {"value": "DONE", "display_name": "Done"}, {"value": "EXPIRED", "display_name": "Expired"}, {"value": "CANCELLED", "display_name": "Cancelled"}], "worker_shelter_role": [{"value": "GUEST", "display_name": "Guest"}, {"value": "WORKER", "display_name": "Worker"}], "user_shelter_role": [{"value": "GUEST", "display_name": "Guest"}, {"value": "WORKER", "display_name": "Worker"}, {"value": "ADMIN", "display_name": "Admin"}], "frontend_info_status": [{"value": "bad_user", "display_name": "Bad user"}, {"value": "bad_shelter", "display_name": "Bad shelter"}, {"value": "email_verified", "display_name": "Email verified"}, {"value": "invalid_link", "display_name": "Invalid link"}, {"value": "verified_by_admin", "display_name": "Verified by admin"}]}'

# ---- детерминированные uuid без Date/random ----
def det_uuid(seed: str) -> str:
    h = hashlib.md5(seed.encode()).hexdigest()
    return f"{h[0:8]}-{h[8:12]}-{h[12:16]}-{h[16:20]}-{h[20:32]}"

# ---- фото ----
def dog_img(n):  return f"https://placedog.net/{{}}?id={n}"
def cat_img(n):  return f"https://cataas.com/cat?width={{w}}&height={{h}}&{n}"  # placeholder, заменим ниже

def thumbs_dog(n):
    # placedog.net хранит id 1..255 — держим seed в этом диапазоне
    n = (n % 250) + 1
    base = "https://placedog.net"
    return {"large": f"{base}/900/600?id={n}", "medium": f"{base}/400/400?id={n}", "small": f"{base}/128/128?id={n}"}

def thumbs_cat(n):
    # cataas отдаёт стабильное фото по /cat/<id-ish> — используем seed через query, картинка кэшируется CDN
    base = f"https://cataas.com/cat"
    return {"large": f"{base}?width=900&height=600&s={n}", "medium": f"{base}?width=400&height=400&s={n}", "small": f"{base}?width=128&height=128&s={n}"}

SHELTER_ID = 1
SHELTER_NAME = "Приют «Добрые лапы»"

# ---- species (виды/породы), level: 1 категория, 2 семейство, 3 вид ----
SPECIES = [
    {"id": 10, "name": "Собака", "level": 1, "parent_id": None, "parent_name": None, "category_name": "Домашнее"},
    {"id": 11, "name": "Кошка", "level": 1, "parent_id": None, "parent_name": None, "category_name": "Домашнее"},
    {"id": 20, "name": "Лабрадор-ретривер", "level": 3, "parent_id": 10, "parent_name": "Собака", "category_name": "Домашнее"},
    {"id": 21, "name": "Немецкая овчарка", "level": 3, "parent_id": 10, "parent_name": "Собака", "category_name": "Домашнее"},
    {"id": 22, "name": "Хаски", "level": 3, "parent_id": 10, "parent_name": "Собака", "category_name": "Домашнее"},
    {"id": 23, "name": "Метис (двортерьер)", "level": 3, "parent_id": 10, "parent_name": "Собака", "category_name": "Домашнее"},
    {"id": 30, "name": "Британская короткошёрстная", "level": 3, "parent_id": 11, "parent_name": "Кошка", "category_name": "Домашнее"},
    {"id": 31, "name": "Мейн-кун", "level": 3, "parent_id": 11, "parent_name": "Кошка", "category_name": "Домашнее"},
    {"id": 32, "name": "Сибирская кошка", "level": 3, "parent_id": 11, "parent_name": "Кошка", "category_name": "Домашнее"},
    {"id": 33, "name": "Метис (беспородная)", "level": 3, "parent_id": 11, "parent_name": "Кошка", "category_name": "Домашнее"},
]
def spec(sid): return next(s for s in SPECIES if s["id"] == sid)

# ============================================================
#  Данные двух организаций (приютов) — выбираются по x-current-shelter
# ============================================================
# Приют 1 — «Добрые лапы» (Москва), приют 2 — «Верный друг» (Санкт-Петербург).
# Диапазоны id не пересекаются, чтобы данные не «протекали» между приютами.

SHELTERS = {
    1: {
        "id": 1, "name": "Приют «Добрые лапы»", "admin": "Мария Администратова",
        "curator_default": "Елена Соколова",
        "curators": [
            {"id": 101, "first_name": "Елена", "last_name": "Соколова", "email": "sokolova.e@dobrye-lapy.ru", "phone_number": "+79161234501", "address": "Москва, ул. Пушкина, 12"},
            {"id": 102, "first_name": "Дмитрий", "last_name": "Ветров", "email": "vetrov.d@dobrye-lapy.ru", "phone_number": "+79161234502", "address": "Москва, ул. Лесная, 8"},
            {"id": 103, "first_name": "Анна", "last_name": "Кузнецова", "email": "kuznetsova.a@dobrye-lapy.ru", "phone_number": "+79161234503", "address": "Москва, пр. Мира, 45"},
        ],
        "applicants": [
            {"id": 201, "first_name": "Ольга", "last_name": "Морозова", "email": "morozova@example.com", "phone_number": "+79031112201", "animal_id": 1002},
            {"id": 202, "first_name": "Игорь", "last_name": "Лебедев", "email": "lebedev@example.com", "phone_number": "+79031112202", "animal_id": None},
        ],
        "adopters": [
            {"id": 301, "first_name": "Наталья", "last_name": "Смирнова", "email": "smirnova@example.com", "phone_number": "+79051113301", "address": "Москва, ул. Садовая, 3"},
            {"id": 302, "first_name": "Павел", "last_name": "Егоров", "email": "egorov@example.com", "phone_number": "+79051113302", "address": "Химки, ул. Зелёная, 17"},
        ],
        "animals": [
            dict(id=1001, name="Рекс", kind="dog", spec=21, status="IN_THE_SHELTER", sex="Мужской", color="Чёрно-рыжий", signs="Белое пятно на груди", birth="2021-05-10", joined="2023-11-02", curator=101, applicant=None, weight="28.5", height="58", chip="643098100001234", place="Москва, Строгино"),
            dict(id=1002, name="Мурка", kind="cat", spec=32, status="OVEREXPOSURE", sex="Женский", color="Серая полосатая", signs="Кисточки на ушах", birth="2022-03-22", joined="2024-01-18", curator=103, applicant=201, weight="4.2", height="26", chip="643098100005678", place="Москва, Митино"),
            dict(id=1003, name="Барон", kind="dog", spec=20, status="HOSPITAL", sex="Мужской", color="Палевый", signs="Шрам на левой лапе", birth="2020-08-01", joined="2023-06-14", curator=102, applicant=None, weight="32.0", height="60", chip="643098100009012", place="Одинцово"),
            dict(id=1004, name="Ласка", kind="cat", spec=31, status="ATTACHED", sex="Женский", color="Рыжая", signs="Пушистый хвост", birth="2021-12-05", joined="2023-09-30", curator=103, applicant=None, weight="5.8", height="30", chip="643098100003456", place="Москва, Тушино"),
            dict(id=1005, name="Джек", kind="dog", spec=22, status="PREPARING_TO_RELEASE", sex="Мужской", color="Чёрно-белый", signs="Голубые глаза", birth="2022-07-19", joined="2024-02-11", curator=101, applicant=None, weight="24.0", height="54", chip="643098100007890", place="Красногорск"),
            dict(id=1006, name="Соня", kind="cat", spec=30, status="IN_THE_SHELTER", sex="Женский", color="Голубая", signs="Круглые оранжевые глаза", birth="2023-01-14", joined="2024-03-05", curator=103, applicant=None, weight="3.9", height="24", chip="", place="Москва, Чертаново"),
            dict(id=1007, name="Тайсон", kind="dog", spec=23, status="IN_THE_SHELTER", sex="Мужской", color="Рыжий", signs="Одно ухо стоит", birth="2020-04-02", joined="2022-12-20", curator=102, applicant=None, weight="19.5", height="50", chip="", place="Люберцы"),
            dict(id=1008, name="Симба", kind="cat", spec=33, status="ATTACHED", sex="Мужской", color="Трёхцветный", signs="Белые носочки", birth="2022-09-09", joined="2023-10-10", curator=101, applicant=None, weight="4.6", height="27", chip="643098100002222", place="Москва, Бирюлёво"),
        ],
        "notes": [
            {"id": 401, "animal": 1001, "content": "Хорошо ладит с другими собаками, любит гулять."},
            {"id": 402, "animal": 1002, "content": "Приучена к лотку, ищет спокойный дом без маленьких детей."},
            {"id": 403, "animal": 1003, "content": "Восстанавливается после операции, аппетит в норме."},
            {"id": 404, "animal": 1001, "content": "Прошёл курс социализации, готов к пристройству."},
            {"id": 405, "animal": 1004, "content": "Очень ласковая, мурлычет при поглаживании."},
        ],
        # передержчики (animal_sitters) — берут животных на временную передержку
        "animal_sitters": [
            {"id": 701, "first_name": "Татьяна", "last_name": "Белова", "email": "belova.t@example.com", "phone_number": "+79161117701", "address": "Москва, ул. Тверская, 5"},
            {"id": 702, "first_name": "Сергей", "last_name": "Романов", "email": "romanov.s@example.com", "phone_number": "+79161117702", "address": "Москва, ул. Арбат, 20"},
        ],
        # усыновления (adoptions): для животных со статусом ATTACHED
        "adoptions": [
            dict(id=801, animal=1004, adopter=301, start_date="2024-05-01", end_date=None),
            dict(id=802, animal=1008, adopter=302, start_date="2024-06-15", end_date=None),
        ],
        # передержки (overstays): для животных на передержке
        "overstays": [
            dict(id=811, animal=1002, animal_sitter=701, start_date="2024-02-10", end_date="2024-04-10"),
        ],
        # выпуски (releases): для готовящихся к выпуску/выпущенных
        "releases": [
            dict(id=821, animal=1005, place="Красногорский лесопарк", date="2024-08-01",
                 vet_name="Дмитрий", vet_surname="Ветров", vet_patronymic="Игоревич"),
        ],
        # prescriptions строятся ниже фабрикой (одинаковая логика, разные животные)
        "prescriptions": [
            dict(id=601, animal=1003, my_type="COURSE_OF_TREATMENT", description="Курс антибиотиков после операции", duration="EVERYDAY", drug=0, dosage=2.0,
                 execs=[("2026-07-10T09:00:00Z","DONE"),("2026-07-11T09:00:00Z","IN_PROGRESS"),("2026-07-12T09:00:00Z","IN_PROGRESS")]),
            dict(id=602, animal=1001, my_type="VACCINATION", description="Ежегодная вакцинация DHPPi", duration="CUSTOM", drug=2, dosage=1.0,
                 execs=[("2026-07-15T11:00:00Z","IN_PROGRESS")]),
            dict(id=603, animal=1002, my_type="PARASITES_TREATMENT", description="Обработка от эктопаразитов", duration="EVERY_WEEK", drug=3, dosage=1.0,
                 execs=[("2026-07-11T08:00:00Z","IN_PROGRESS")], extra={"parasites_type": "ECTOPARASITES"}),
            dict(id=604, animal=1005, my_type="APPOINTMENT", description="Приём у ветеринара перед выпуском", duration="CUSTOM",
                 execs=[("2026-07-13T10:30:00Z","IN_PROGRESS")]),
            dict(id=605, animal=1003, my_type="REMOVING_STITCHES", description="Снятие швов", duration="CUSTOM",
                 execs=[("2026-07-18T12:00:00Z","IN_PROGRESS")]),
            dict(id=606, animal=1004, my_type="ANALYSIS", description="Общий анализ крови", duration="CUSTOM",
                 execs=[("2026-07-09T09:30:00Z","DONE")]),
            dict(id=607, animal=1006, my_type="OTHER", description="Контроль веса раз в неделю", duration="EVERY_WEEK",
                 execs=[("2026-07-14T09:00:00Z","IN_PROGRESS")]),
        ],
        "drug_residues": [12, 40, 8, 25, None],
    },
    2: {
        "id": 2, "name": "Приют «Верный друг»", "admin": "Мария Администратова",
        "curator_default": "Виктор Орлов",
        "curators": [
            {"id": 111, "first_name": "Виктор", "last_name": "Орлов", "email": "orlov.v@verny-drug.ru", "phone_number": "+78121234511", "address": "СПб, Невский пр., 20"},
            {"id": 112, "first_name": "Светлана", "last_name": "Зайцева", "email": "zaytseva.s@verny-drug.ru", "phone_number": "+78121234512", "address": "СПб, ул. Марата, 5"},
        ],
        "applicants": [
            {"id": 211, "first_name": "Екатерина", "last_name": "Волкова", "email": "volkova@example.com", "phone_number": "+79219992211", "animal_id": 2002},
        ],
        "adopters": [
            {"id": 311, "first_name": "Андрей", "last_name": "Соколов", "email": "sokolov@example.com", "phone_number": "+79219993311", "address": "СПб, ул. Рубинштейна, 8"},
        ],
        "animals": [
            dict(id=2001, name="Граф", kind="dog", spec=21, status="IN_THE_SHELTER", sex="Мужской", color="Чепрачный", signs="Умный взгляд", birth="2021-02-14", joined="2024-04-01", curator=111, applicant=None, weight="30.0", height="62", chip="643098200001111", place="СПб, Приморский"),
            dict(id=2002, name="Багира", kind="cat", spec=32, status="OVEREXPOSURE", sex="Женский", color="Чёрная", signs="Зелёные глаза", birth="2022-06-01", joined="2024-05-12", curator=112, applicant=211, weight="3.8", height="25", chip="643098200002222", place="СПб, Купчино"),
            dict(id=2003, name="Локи", kind="dog", spec=22, status="PREPARING_TO_RELEASE", sex="Мужской", color="Серо-белый", signs="Разные глаза", birth="2022-11-11", joined="2024-06-20", curator=111, applicant=None, weight="23.0", height="55", chip="", place="Всеволожск"),
            dict(id=2004, name="Ася", kind="cat", spec=31, status="IN_THE_SHELTER", sex="Женский", color="Дымчатая", signs="Длинная шерсть", birth="2023-03-08", joined="2024-07-02", curator=112, applicant=None, weight="4.9", height="28", chip="643098200004444", place="СПб, Парнас"),
            dict(id=2005, name="Тор", kind="dog", spec=20, status="HOSPITAL", sex="Мужской", color="Золотистый", signs="Добрый нрав", birth="2020-09-19", joined="2023-12-15", curator=111, applicant=None, weight="34.0", height="61", chip="643098200005555", place="Пушкин"),
            dict(id=2006, name="Феня", kind="cat", spec=33, status="ATTACHED", sex="Женский", color="Рыже-белая", signs="Пятно на носу", birth="2022-12-25", joined="2024-01-30", curator=112, applicant=None, weight="4.1", height="26", chip="", place="СПб, Колпино"),
        ],
        "notes": [
            {"id": 411, "animal": 2001, "content": "Прошёл базовую дрессировку, знает команды."},
            {"id": 412, "animal": 2002, "content": "Осторожна с незнакомцами, нужен терпеливый хозяин."},
            {"id": 413, "animal": 2003, "content": "Готовится к выпуску, привит и стерилизован."},
            {"id": 414, "animal": 2005, "content": "На лечении, динамика положительная."},
        ],
        "animal_sitters": [
            {"id": 711, "first_name": "Марина", "last_name": "Кораблёва", "email": "korableva.m@example.com", "phone_number": "+79211117711", "address": "СПб, ул. Восстания, 3"},
            {"id": 712, "first_name": "Алексей", "last_name": "Соловьёв", "email": "solovyov.a@example.com", "phone_number": "+79211117712", "address": "СПб, ул. Садовая, 14"},
        ],
        "adoptions": [
            dict(id=831, animal=2006, adopter=311, start_date="2024-04-20", end_date=None),
        ],
        "overstays": [
            dict(id=841, animal=2002, animal_sitter=711, start_date="2024-05-15", end_date=None),
        ],
        "releases": [
            dict(id=851, animal=2003, place="Всеволожский лес", date="2024-07-20",
                 vet_name="Виктор", vet_surname="Орлов", vet_patronymic="Петрович"),
        ],
        "prescriptions": [
            dict(id=611, animal=2005, my_type="COURSE_OF_TREATMENT", description="Курс лечения ЖКТ", duration="EVERYDAY", drug=0, dosage=1.5,
                 execs=[("2026-07-11T10:00:00Z","IN_PROGRESS"),("2026-07-12T10:00:00Z","IN_PROGRESS")]),
            dict(id=612, animal=2001, my_type="VACCINATION", description="Комплексная вакцинация", duration="CUSTOM", drug=2, dosage=1.0,
                 execs=[("2026-07-16T12:00:00Z","IN_PROGRESS")]),
            dict(id=613, animal=2002, my_type="PARASITES_TREATMENT", description="Обработка от гельминтов", duration="EVERY_WEEK", drug=1, dosage=1.0,
                 execs=[("2026-07-11T09:00:00Z","IN_PROGRESS")], extra={"parasites_type": "ENDOPARASITES"}),
            dict(id=614, animal=2003, my_type="APPOINTMENT", description="Осмотр перед выпуском", duration="CUSTOM",
                 execs=[("2026-07-14T11:00:00Z","IN_PROGRESS")]),
        ],
        "drug_residues": [6, 22, 15, 30, 4],
    },
}

# Активный приют — фабрика ниже переустанавливает эти глобали для каждого id.
SHELTER_ID = 1
SHELTER_NAME = SHELTERS[1]["name"]
CURATORS = SHELTERS[1]["curators"]
APPLICANTS = SHELTERS[1]["applicants"]
ADOPTERS = SHELTERS[1]["adopters"]
ANIMALS = SHELTERS[1]["animals"]
NOTES = SHELTERS[1]["notes"]
ANIMAL_SITTERS = SHELTERS[1]["animal_sitters"]
ADOPTIONS = SHELTERS[1]["adoptions"]
OVERSTAYS = SHELTERS[1]["overstays"]
RELEASES = SHELTERS[1]["releases"]
_ADMIN = SHELTERS[1]["admin"]
_CURATOR_DEFAULT = SHELTERS[1]["curator_default"]

def curator_obj(c):
    return {
        "id": c["id"], "url": f"/api/v1/curators/{c['id']}/", "shelter": SHELTER_NAME,
        "first_name": c["first_name"], "last_name": c["last_name"], "email": c["email"],
        "phone_number": c["phone_number"], "address": c["address"],
        "created_by": _ADMIN, "updated_by": _ADMIN,
        "created_at": "2024-01-15T10:00:00Z", "updated_at": "2024-02-01T12:30:00Z",
    }

def applicant_obj(a):
    return {
        "id": a["id"], "url": f"/api/v1/applicants/{a['id']}/", "shelter": SHELTER_ID,
        "first_name": a["first_name"], "last_name": a["last_name"], "email": a["email"],
        "phone_number": a["phone_number"], "contact_details": "Готов(а) приехать в выходные",
        "created_by": _ADMIN, "updated_by": _ADMIN,
        "created_at": "2024-05-20T14:00:00Z", "updated_at": "2024-05-22T09:15:00Z",
        "animal_id": a["animal_id"], "applicant_files": [],
    }

def adopter_obj(a):
    return {
        "id": a["id"], "url": f"/api/v1/adopters/{a['id']}/", "shelter": SHELTER_NAME,
        "first_name": a["first_name"], "last_name": a["last_name"], "email": a["email"],
        "phone_number": a["phone_number"], "address": a["address"],
        "created_by": _ADMIN, "updated_by": _ADMIN,
        "created_at": "2024-04-10T11:00:00Z", "updated_at": "2024-04-10T11:00:00Z",
    }

def animal_image_block(a, primary=True, extra=0):
    seed = a["id"] * 10 + extra
    t = thumbs_dog(seed) if a["kind"] == "dog" else thumbs_cat(seed)
    return {
        "id": a["id"] * 100 + extra,
        "is_primary": primary,
        "filename": f"{a['name'].lower()}_{seed}.jpg",
        "image": t,
    }

def animal_attributes(a):
    attrs = [{"attr_id": 5, "name": "sex", "value": a["sex"], "is_required": True}]
    if a.get("color"): attrs.append({"attr_id": 6, "name": "color", "value": a["color"], "is_required": False})
    if a.get("signs"): attrs.append({"attr_id": 7, "name": "special_signs", "value": a["signs"], "is_required": False})
    return attrs

def animal_read(a, detail=False):
    imgs = [animal_image_block(a, True, 0)]
    if detail:
        imgs.append(animal_image_block(a, False, 1))
    cur = curator_obj(next(c for c in CURATORS if c["id"] == a["curator"])) if a.get("curator") else None
    app = None
    if a.get("applicant"):
        ap = next(x for x in APPLICANTS if x["id"] == a["applicant"])
        app = applicant_obj(ap)
    return {
        "id": a["id"],
        "uuid": det_uuid(f"animal-{a['id']}"),
        "url": f"/api/v1/animals/{a['id']}/",
        "name": a["name"],
        "images": imgs,
        "spec": spec(a["spec"]),
        "status": a["status"],
        "date_joined": a["joined"],
        "birth_date": a["birth"],
        "death_date": None,
        "death_reason": "",
        "default_image_id": imgs[0]["id"],
        "place_of_catch": a["place"],
        "place_of_release": "",
        "date_of_chipping": "2023-12-01" if a["chip"] else None,
        "chipping_code": a["chip"],
        "height": a["height"],
        "weight": a["weight"],
        "has_documents": bool(a["chip"]),
        "shelter": SHELTER_ID,
        "curator": cur,
        "applicant": app,
        "animal_attributes": animal_attributes(a),
        "deleted_at": None,
        "adoption": adoption_obj(next((x for x in ADOPTIONS if x["animal"] == a["id"]), None)) if any(x["animal"] == a["id"] for x in ADOPTIONS) else None,
        "release": release_obj(next((x for x in RELEASES if x["animal"] == a["id"]), None)) if any(x["animal"] == a["id"] for x in RELEASES) else None,
        "overstay": overstay_obj(next((x for x in OVERSTAYS if x["animal"] == a["id"]), None)) if any(x["animal"] == a["id"] for x in OVERSTAYS) else None,
        "can_be_shared": True,
    }

def animal_short(a):
    seed = a["id"] * 10
    avatar = thumbs_dog(seed)["small"] if a["kind"] == "dog" else thumbs_cat(seed)["small"]
    s = spec(a["spec"])
    return {
        "id": a["id"], "uuid": det_uuid(f"animal-{a['id']}"), "name": a["name"],
        "spec_name": s["name"], "spec_parent_name": s.get("parent_name"),
        "avatar": avatar, "default_image_id": a["id"] * 100,
    }

# ---- лекарства ----
DRUGS = [
    {"id": 501, "name": "Гентамицин 4%", "usage_instruction": "Антибактериальные средства", "form_of_drug": 1, "form_of_drug_name": "мл"},
    {"id": 502, "name": "Дронтал плюс", "usage_instruction": "Антигельминтные средства", "form_of_drug": 2, "form_of_drug_name": "таб"},
    {"id": 503, "name": "Нобивак DHPPi", "usage_instruction": "Вакцина комплексная", "form_of_drug": 1, "form_of_drug_name": "доза"},
    {"id": 504, "name": "Фронтлайн Спот-он", "usage_instruction": "От блох и клещей", "form_of_drug": 1, "form_of_drug_name": "пипетка"},
    {"id": 505, "name": "Мелоксикам 1.5 мг", "usage_instruction": "Противовоспалительное", "form_of_drug": 1, "form_of_drug_name": "мл"},
]
def drug_obj(d): return dict(d)

# ---- назначения (prescriptions), полиморфные по my_type ----
def pdrug(d, dosage):
    return {"drug_id": d["id"], "drug_name": d["name"], "usage_instruction": d["usage_instruction"],
            "form_of_drug": d["form_of_drug_name"], "drug_dosage": dosage}

def build_prescription(spec_dict, vet_name):
    """spec_dict — компактное описание из SHELTERS; собираем полный объект."""
    eid_base = spec_dict["id"] * 10
    drugs = []
    if "drug" in spec_dict:
        drugs = [pdrug(DRUGS[spec_dict["drug"]], spec_dict.get("dosage", 1.0))]
    executions = [{"id": eid_base + i, "execute_at": at, "status": st}
                  for i, (at, st) in enumerate(spec_dict.get("execs", []))]
    return {
        "id": spec_dict["id"], "url": f"/api/v1/prescriptions/{spec_dict['id']}/", "animal": spec_dict["animal"],
        "my_type": spec_dict["my_type"], "extra_type_attributes": spec_dict.get("extra", {}),
        "duration": spec_dict.get("duration", "CUSTOM"), "description": spec_dict["description"],
        "created_by": vet_name, "updated_by": vet_name,
        "drugs": drugs, "executions": executions, "files": [],
    }

def prescription_short(p):
    a = next(x for x in ANIMALS if x["id"] == p["animal"])
    return {
        "id": p["id"], "my_type": p["my_type"], "extra_type_attributes": p["extra_type_attributes"],
        "description": p["description"], "animal": animal_short(a),
        "drugs": p["drugs"], "created_by": p["created_by"], "updated_by": p["updated_by"],
        "files": [],
    }

def note_obj(n):
    return {
        "id": n["id"], "url": f"/api/v1/animals/notes/{n['id']}/", "animal": n["animal"],
        "content": n["content"], "files": [],
        "created_at": "2024-06-01T10:00:00Z", "updated_at": "2024-06-01T10:00:00Z",
        "created_by": _CURATOR_DEFAULT, "updated_by": _CURATOR_DEFAULT,
        "is_user_can_edit_or_delete": True,
    }

def animal_sitter_obj(s):
    return {
        "id": s["id"], "url": f"/api/v1/animal_sitters/{s['id']}/", "shelter": SHELTER_NAME,
        "first_name": s["first_name"], "last_name": s["last_name"], "email": s["email"],
        "phone_number": s["phone_number"], "address": s["address"],
        "created_by": _ADMIN, "updated_by": _ADMIN,
        "created_at": "2024-03-01T10:00:00Z", "updated_at": "2024-03-05T12:00:00Z",
    }

def adoption_obj(a):
    return {
        "id": a["id"], "start_date": a.get("start_date"), "end_date": a.get("end_date"),
        "adopter": a.get("adopter"),
    }

def overstay_obj(o):
    return {
        "id": o["id"], "start_date": o.get("start_date"), "end_date": o.get("end_date"),
        "animal_sitter": o.get("animal_sitter"),
    }

def release_obj(r):
    return {
        "id": r["id"], "place": r.get("place"), "date": r.get("date"),
        "veterinarian_name": r.get("vet_name"), "veterinarian_surname": r.get("vet_surname"),
        "veterinarian_patronymic": r.get("vet_patronymic"),
        "created_at": "2024-07-01T09:00:00Z", "updated_at": "2024-07-01T09:00:00Z",
    }

def paginated(results):
    return {"count": len(results), "next": None, "previous": None, "results": results}

# ============================================================
#  Сборка тел ответов
# ============================================================

# Реквизиты приютов для shelter_detail (различаются между организациями).
SHELTER_DETAILS = {
    1: {
        "country": "Россия", "city": "Москва", "region": "Московская область",
        "street": "Приютская", "house": "7", "official_name": "АНО «Добрые лапы»",
        "ogrn": "1157700000123", "inn": "7701234567", "kpp": "770101001",
        "organization_email": "info@dobrye-lapy.ru", "phone_number": "+74951234567",
        "website_link": "https://dobrye-lapy.ru",
        "first_name_of_manager": "Мария", "last_name_of_manager": "Администратова", "middle_name_of_manager": "Ивановна",
        "legal_address_of_the_bank": "Москва, ул. Вавилова, 19",
    },
    2: {
        "country": "Россия", "city": "Санкт-Петербург", "region": "Ленинградская область",
        "street": "Лиговский пр.", "house": "44", "official_name": "АНО «Верный друг»",
        "ogrn": "1157800000456", "inn": "7801234567", "kpp": "780101001",
        "organization_email": "info@verny-drug.ru", "phone_number": "+78121234567",
        "website_link": "https://verny-drug.ru",
        "first_name_of_manager": "Мария", "last_name_of_manager": "Администратова", "middle_name_of_manager": "Ивановна",
        "legal_address_of_the_bank": "СПб, Невский пр., 38",
    },
}

def shelter_detail_body(sid):
    s = SHELTERS[sid]; d = SHELTER_DETAILS[sid]
    return {
        "id": sid, "name": s["name"], "country": d["country"], "city": d["city"], "state": "",
        "region": d["region"], "street": d["street"], "house": d["house"], "apartment": "",
        "official_name": d["official_name"], "ogrn": d["ogrn"], "inn": d["inn"], "kpp": d["kpp"],
        "organization_email": d["organization_email"], "phone_number": d["phone_number"],
        "website_link": d["website_link"], "position_of_manager": "Директор",
        "first_name_of_manager": d["first_name_of_manager"], "last_name_of_manager": d["last_name_of_manager"],
        "middle_name_of_manager": d["middle_name_of_manager"],
        "full_name_of_the_bank": "ПАО Сбербанк", "short_bank_name": "Сбербанк", "full_english_bank_name": "Sberbank",
        "legal_address_of_the_bank": d["legal_address_of_the_bank"], "postal_address_of_the_bank": d["legal_address_of_the_bank"],
        "correspondent_account_of_the_bank": "30101810400000000225", "payment_account_of_the_organization": "40703810000000000123",
        "bic_of_the_bank": "044525225",
    }

def stats_body(sid):
    animals = SHELTERS[sid]["animals"]
    from collections import Counter
    breeds = Counter(a["spec"] for a in animals)
    dogs = sum(1 for a in animals if a["kind"] == "dog")
    cats = sum(1 for a in animals if a["kind"] == "cat")
    return {
        "breeds": [{"id": s_id, "name": spec(s_id)["name"], "count": cnt} for s_id, cnt in sorted(breeds.items())],
        "species": [{"id": 10, "name": "Собака", "count": dogs}, {"id": 11, "name": "Кошка", "count": cats}],
    }

def build_shelter_bodies(sid):
    """Тела ответов, зависящие от текущего приюта (x-current-shelter)."""
    # переустанавливаем активный контекст для *_obj функций
    global SHELTER_ID, SHELTER_NAME, CURATORS, APPLICANTS, ADOPTERS, ANIMALS, NOTES, _ADMIN, _CURATOR_DEFAULT
    global ANIMAL_SITTERS, ADOPTIONS, OVERSTAYS, RELEASES
    s = SHELTERS[sid]
    SHELTER_ID = sid
    SHELTER_NAME = s["name"]
    CURATORS = s["curators"]
    APPLICANTS = s["applicants"]
    ADOPTERS = s["adopters"]
    ANIMALS = s["animals"]
    NOTES = s["notes"]
    ANIMAL_SITTERS = s["animal_sitters"]
    ADOPTIONS = s["adoptions"]
    OVERSTAYS = s["overstays"]
    RELEASES = s["releases"]
    _ADMIN = s["admin"]
    _CURATOR_DEFAULT = s["curator_default"]
    vet = s["curators"][0]["first_name"] + " " + s["curators"][0]["last_name"]

    prescriptions = [build_prescription(p, vet) for p in s["prescriptions"]]
    exec_today = []
    eid = sid * 100000
    for p in prescriptions:
        for ex in p["executions"]:
            if ex["status"] == "IN_PROGRESS":
                eid += 1
                exec_today.append({"id": eid, "prescription": prescription_short(p), "execute_at": ex["execute_at"]})

    workers = [
        {"id": sid * 1000 + 1, "user": WORKER_USERS[0], "role": "WORKER", "is_verified_by_admin": True},
        {"id": sid * 1000 + 2, "user": WORKER_USERS[1], "role": "WORKER", "is_verified_by_admin": True},
        {"id": sid * 1000 + 3, "user": WORKER_USERS[2], "role": "GUEST", "is_verified_by_admin": None},
    ]

    return {
        "current_shelter": {"current_shelter": sid, "current_shelter_user_role": "ADMIN", "is_user_can_edit": True, "is_user_can_delete": True},
        "shelter_detail": shelter_detail_body(sid),
        "animals_list": paginated([animal_read(a) for a in ANIMALS]),
        "animals_detail": {a["id"]: animal_read(a, detail=True) for a in ANIMALS},
        "stats": stats_body(sid),
        "curators_list": paginated([curator_obj(c) for c in CURATORS]),
        "curators_detail": {c["id"]: curator_obj(c) for c in CURATORS},
        "adopters_list": paginated([adopter_obj(a) for a in ADOPTERS]),
        "adopters_detail": {a["id"]: adopter_obj(a) for a in ADOPTERS},
        "applicants_list": paginated([applicant_obj(a) for a in APPLICANTS]),
        "applicants_detail": {a["id"]: applicant_obj(a) for a in APPLICANTS},
        "notes_list": paginated([note_obj(n) for n in NOTES]),
        "notes_detail": {n["id"]: note_obj(n) for n in NOTES},
        "animal_sitters_list": paginated([animal_sitter_obj(x) for x in ANIMAL_SITTERS]),
        "animal_sitters_detail": {x["id"]: animal_sitter_obj(x) for x in ANIMAL_SITTERS},
        "adoptions_list": paginated([adoption_obj(x) for x in ADOPTIONS]),
        "adoptions_detail": {x["id"]: adoption_obj(x) for x in ADOPTIONS},
        "overstays_list": paginated([overstay_obj(x) for x in OVERSTAYS]),
        "overstays_detail": {x["id"]: overstay_obj(x) for x in OVERSTAYS},
        "releases_list": paginated([release_obj(x) for x in RELEASES]),
        "releases_detail": {x["id"]: release_obj(x) for x in RELEASES},
        "prescriptions_list": paginated([prescription_short(p) for p in prescriptions]),
        "prescriptions_detail": {p["id"]: p for p in prescriptions},
        "prescriptions_executions": paginated(exec_today),
        "drugs_list": paginated([{"drug": drug_obj(d), "drug_residues_count": r} for d, r in zip(DRUGS, s["drug_residues"])]),
        "workers_list": paginated(workers),
    }

# общие для всех приютов пользователи-работники (в workers_list)
WORKER_USERS = [
    {"id": 1, "username": "admin@acits.ru", "first_name": "Мария", "last_name": "Администратова",
     "fathers_name": "Ивановна", "full_name": "Мария Администратова", "email": "admin@acits.ru",
     "phone_number": "+79160000000", "address": "", "date_joined": "2024-01-01T09:00:00Z",
     "is_verified": True, "is_offer_signed": True},
    {"id": 2, "username": "vet@acits.ru", "first_name": "Дмитрий", "last_name": "Ветров",
     "fathers_name": "", "full_name": "Дмитрий Ветров", "email": "vet@acits.ru",
     "phone_number": "+79160000001", "address": "", "date_joined": "2024-02-10T09:00:00Z",
     "is_verified": True, "is_offer_signed": True},
    {"id": 3, "username": "guest@acits.ru", "first_name": "Ольга", "last_name": "Гостева",
     "fathers_name": "", "full_name": "Ольга Гостева", "email": "guest@acits.ru",
     "phone_number": "", "address": "", "date_joined": "2025-06-01T09:00:00Z",
     "is_verified": True, "is_offer_signed": False},
]

# ---- глобальные тела (не зависят от приюта) ----
GLOBAL = {}
GLOBAL["token"] = {
    "access": "mock.access.token.eyJ1c2VyIjoiYWxla3MiLCJyb2xlIjoiQURNSU4ifQ",
    "refresh": "mock.refresh.token.eyJ0eXAiOiJyZWZyZXNoIn0",
}
GLOBAL["token_refresh"] = {"access": "mock.access.token.refreshed.eyJ1c2VyIjoiYWxla3MifQ"}
GLOBAL["me"] = {
    "id": 1, "username": "admin@acits.ru", "first_name": "Мария", "last_name": "Администратова",
    "fathers_name": "Ивановна", "full_name": "Мария Администратова", "email": "admin@acits.ru",
    "phone_number": "+79160000000", "address": "Москва", "date_joined": "2024-01-01T09:00:00Z",
    "is_verified": True, "is_offer_signed": True,
}
# обе организации доступны пользователю
GLOBAL["my_shelters"] = paginated([{"id": sid, "name": SHELTERS[sid]["name"]} for sid in SHELTERS])
GLOBAL["available_shelters"] = paginated(
    [{"id": sid, "name": SHELTERS[sid]["name"]} for sid in SHELTERS] +
    [{"id": 3, "name": "Приют «Кошкин дом»"}, {"id": 4, "name": "Приют «Лесная сказка»"}]
)
GLOBAL["species_list"] = paginated(SPECIES)
GLOBAL["attributes"] = [
    {"id": 5, "name": "sex", "is_required": True},
    {"id": 6, "name": "color", "is_required": False},
    {"id": 7, "name": "special_signs", "is_required": False},
]
GLOBAL["available_workers"] = paginated([
    {"id": 2, "full_name": "Дмитрий Ветров", "email": "vet@acits.ru", "phone_number": "+79160000001", "address": ""},
    {"id": 3, "full_name": "Ольга Гостева", "email": "guest@acits.ru", "phone_number": "", "address": ""},
])
GLOBAL["values"] = json.loads(VALUES_JSON)

# ---- финальная структура: {global:{...}, shelters:{"1":{...},"2":{...}}} ----
OUT = {"global": GLOBAL, "shelters": {str(sid): build_shelter_bodies(sid) for sid in SHELTERS}}

import os
_HERE = os.path.dirname(os.path.abspath(__file__))
json.dump(OUT, open(os.path.join(_HERE, "_bodies.json"), "w"), ensure_ascii=False)
print("global keys:", len(GLOBAL), "| shelters:", list(OUT["shelters"].keys()))
for sid in SHELTERS:
    sb = OUT["shelters"][str(sid)]
    print(f"  shelter {sid}: animals={sb['animals_list']['count']} prescriptions={sb['prescriptions_list']['count']} exec_today={sb['prescriptions_executions']['count']} notes={sb['notes_list']['count']} sitters={sb['animal_sitters_list']['count']} adoptions={sb['adoptions_list']['count']} overstays={sb['overstays_list']['count']} releases={sb['releases_list']['count']}")
