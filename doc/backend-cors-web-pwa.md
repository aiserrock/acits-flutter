# CORS для web-PWA (GitHub Pages) — что сделать на бэке

## Проблема

Web-версия приложения хостится на GitHub Pages
(`https://aiserrock.github.io/acits-flutter/`) и ходит на API напрямую из
браузера. Браузер шлёт `Origin: https://aiserrock.github.io`, а CORS-allowlist
бэка пускает только `https://acits.ru` и `https://www.acits.ru` — ответ
приходит без `Access-Control-Allow-Origin`, и браузер блокирует ВСЕ запросы.
Это одинаково на всех контурах (prod / stage / dev-0..3 — проверено curl'ом).

Сейчас клиент работает через публичный CORS-прокси (proxy.cors.sh) — это
временный костыль: чужой сервер видит весь трафик, включая JWT.

## Что сделать (Django + django-cors-headers)

В settings контуров **dev-0..3 и stage** (prod — по желанию) добавить origin
PWA:

```python
CORS_ALLOWED_ORIGINS = [
    "https://acits.ru",
    "https://www.acits.ru",
    "https://aiserrock.github.io",   # ← добавить: web-PWA (GitHub Pages)
]
```

Если авторизация когда-нибудь переедет на cookie (сейчас — Bearer в
заголовке, куки не нужны), то дополнительно:

```python
CORS_ALLOW_CREDENTIALS = True          # уже стоит (allow-credentials: true в ответах)
CSRF_TRUSTED_ORIGINS = ["https://aiserrock.github.io"]
```

Заголовки, которые шлёт клиент (должны быть разрешены в
`CORS_ALLOW_HEADERS`, дефолт django-cors-headers уже покрывает почти всё):
`authorization`, `content-type`, `x-current-shelter`.

## Как проверить

```bash
curl -s -o /dev/null -D - "https://dev-0.app.acits.ru/api/v1/shelters/?limit=1" \
  -H "Origin: https://aiserrock.github.io" | grep -i access-control-allow-origin
# ожидаем: access-control-allow-origin: https://aiserrock.github.io
```

## После фикса на бэке

Убрать `--dart-define=CORS_PROXY_BASE=...` из шага «Build web (dev)» в
`.github/workflows/ci.yml` — клиент начнёт ходить на API напрямую.
