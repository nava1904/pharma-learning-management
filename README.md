# Pharma LMS — Enterprise Pharmaceutical Learning Management System

Enterprise-grade compliance LMS for pharmaceutical companies.  
Built for **FDA 21 CFR Part 11**, **GxP**, **EU Annex 11**, and **ALCOA+ data integrity**.

---

## Tech Stack

| Layer       | Technology                                      |
| ----------- | ----------------------------------------------- |
| Frontend    | Flutter 3.x · Riverpod · GoRouter · Material 3  |
| Backend     | Serverpod (Dart) · PostgreSQL · Redis            |
| Real-time   | WebSocket via Serverpod streaming                |
| Storage     | S3 / MinIO for documents & media                 |
| CI / CD     | GitHub Actions → Render (API) + Vercel (Web)     |

---

## Repository Structure

```
pharma_learning_management/
├── pharma_lms/                    # Serverpod mono-repo
│   ├── pharma_lms_flutter/        #   Flutter web/mobile app
│   ├── pharma_lms_server/         #   Serverpod backend + migrations
│   ├── pharma_lms_client/         #   Auto-generated Dart client
│   ├── docker/                    #   Docker compose configs
│   └── docs/                      #   Internal dev docs (routing, QA)
├── docs/                          # Architecture & design documentation
├── .github/                       # CI/CD workflows
├── render.yaml                    # Render.com deployment config
├── vercel.json                    # Vercel static deploy config
└── .gitignore
```

---

## Quick Start

### Prerequisites

- Flutter SDK ≥ 3.22
- Dart SDK ≥ 3.4
- Docker Desktop (for PostgreSQL)
- Serverpod CLI (`dart pub global activate serverpod_cli`)

### 1. Start the database

```bash
cd pharma_lms/pharma_lms_server
docker compose up -d postgres
```

### 2. Run migrations & generate code

```bash
serverpod generate
dart run bin/main.dart --apply-migrations
```

### 3. Start the server

```bash
dart run bin/main.dart
```

### 4. Run the Flutter app

```bash
cd ../pharma_lms_flutter
flutter run -d chrome
```

> **Full guide →** [docs/LOCAL_DEVELOPMENT_SETUP.md](docs/LOCAL_DEVELOPMENT_SETUP.md)

---

## Documentation

| Document | Description |
| -------- | ----------- |
| [Local Development Setup](docs/LOCAL_DEVELOPMENT_SETUP.md) | Step-by-step dev environment guide |
| [System Design & Architecture](docs/SYSTEM_DESIGN_ARCHITECTURE.md) | High-level architecture overview |
| [Project Architecture](docs/PROJECT_ARCHITECTURE_AND_DESIGN.md) | Code structure & design patterns |
| [Database Schema](docs/DATABASE_SCHEMA_README.md) | Entity-relationship & migration guide |
| [Deployment](docs/DEPLOYMENT.md) | Render + Vercel deployment instructions |
| [Employee Portal](docs/EMPLOYEE_PORTAL_SYSTEM_DESIGN.md) | Employee portal system design |
| [Trainer Portal](docs/TRAINER_PORTAL_SYSTEM_DESIGN.md) | Trainer portal system design |
| [SSO / OIDC](docs/SSO_OIDC_INTEGRATION.md) | Single sign-on integration guide |
| [Email Service](docs/EMAIL_SERVICE.md) | Transactional email setup |
| [S3 Storage](docs/STORAGE_S3.md) | File storage configuration |
| [Enterprise Roadmap](docs/PHARMA_LMS_ENTERPRISE_ROADMAP.md) | Future feature roadmap |

---

## License

Proprietary — © 2026 Pharma LMS. All rights reserved.
