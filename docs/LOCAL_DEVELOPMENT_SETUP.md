# Pharma LMS — Local Development Setup

Step-by-step guide to run Pharma LMS on your machine for the first time.

---

## Prerequisites

- **Dart SDK** 3.8+ ([dart.dev](https://dart.dev/get-dart))
- **Flutter** 3.32+ ([flutter.dev](https://flutter.dev))
- **Docker** & **Docker Compose** ([docker.com](https://docker.com))
- **Serverpod CLI**: `dart pub global activate serverpod_cli` (then ensure `~/.pub-cache/bin` is in your PATH)

---

## Step 1: Start Database (PostgreSQL)

Pharma LMS uses PostgreSQL. Start it with Docker:

```bash
cd pharma_lms/pharma_lms_server
docker compose up -d postgres
```

This starts PostgreSQL on **port 8090** with:
- Database: `pharma_lms`
- User: `postgres`
- Password: from `config/passwords.yaml` (development.database)

Verify it's running:

```bash
docker compose ps
```

---

## Step 2: Install Dependencies

From the project root:

```bash
cd pharma_lms
dart pub get
cd pharma_lms_server && dart pub get
cd ../pharma_lms_client && dart pub get
cd ../pharma_lms_flutter && flutter pub get
```

---

## Step 3: Run the Server

```bash
cd pharma_lms/pharma_lms_server
serverpod run
```

**If `serverpod` is not found**, run manually:

```bash
dart run bin/main.dart --apply-migrations
```

This will:
- Apply database migrations
- Start API server on **8080**
- Start Insights server on **8081**
- Start Web server on **8082**

---

## Step 4: Build and Serve the Flutter App

### Option A: Build and serve from Serverpod (recommended)

```bash
cd pharma_lms/pharma_lms_server
serverpod run flutter_build
```

**If `serverpod` is not found**, run the build manually:

```bash
cd pharma_lms/pharma_lms_flutter
flutter build web --base-href /app/ --wasm
cp -r build/web/* ../pharma_lms_server/web/app/
```

Then open: **http://localhost:8082/app**

### Option B: Flutter dev server (hot reload)

```bash
cd pharma_lms/pharma_lms_flutter
flutter run -d chrome
```

The app will connect to the API at `http://127.0.0.1:8082/api/` (see `assets/config.json`).

---

## Step 5: Seed Sample Data

1. Open **http://localhost:8082/app** (or your Flutter dev URL)
2. On the login screen, click **"Seed sample data"**
3. Wait for the seed to complete
4. Log in with the seeded credentials (e.g. `admin@example.com` / password from seed)

---

## Port Summary

| Service    | Port | URL                    |
|-----------|------|------------------------|
| API       | 8080 | http://localhost:8080  |
| Insights  | 8081 | http://localhost:8081  |
| Web + App | 8082 | http://localhost:8082/app |
| PostgreSQL| 8090 | localhost:8090         |
| Redis     | 8091 | localhost:8091 (optional) |

---

## Optional: Redis

Redis is **disabled** by default in development. To enable:

1. Start Redis: `docker compose up -d redis`
2. In `config/development.yaml`, set `redis.enabled: true`

---

## Optional: Full Stack (PostgreSQL + Redis + Kafka)

For analytics/event features:

```bash
cd pharma_lms
docker compose -f docker/docker-compose.full.yaml up -d
```

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| **Database connection failed** | Ensure `docker compose up -d postgres` ran. Check `config/development.yaml` and `config/passwords.yaml` match docker-compose. |
| **Port already in use** | Change ports in `config/development.yaml` or stop the conflicting process. |
| **"Build Flutter app" page** | Run `serverpod run flutter_build` from `pharma_lms_server`. |
| **API connection refused** | Ensure Serverpod is running (`serverpod run`). |
| **Migrations fail** | Ensure PostgreSQL is up and the database `pharma_lms` exists. |

---

## Quick Reference

```bash
# One-time setup
cd pharma_lms/pharma_lms_server
docker compose up -d postgres
serverpod run flutter_build

# Daily development
cd pharma_lms/pharma_lms_server
serverpod run
# Open http://localhost:8082/app
```
