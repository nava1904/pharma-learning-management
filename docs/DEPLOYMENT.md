# Pharma LMS - Deployment Guide

This document covers the complete CI/CD setup and deployment process for the Pharma Learning Management System.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           PRODUCTION ENVIRONMENT                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   ┌──────────────┐         ┌──────────────┐         ┌──────────────┐   │
│   │   Vercel     │         │   Render     │         │   Render     │   │
│   │  (Frontend)  │ ──────► │   (API)      │ ──────► │ (PostgreSQL) │   │
│   │              │         │              │         │              │   │
│   │ Flutter Web  │  HTTPS  │  Serverpod   │   SSL   │   Database   │   │
│   └──────────────┘         └──────────────┘         └──────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

## Deployment Stack

| Component | Platform | URL Pattern |
|-----------|----------|-------------|
| Frontend (Flutter Web) | Vercel | `pharma-lms.vercel.app` |
| Backend API (Serverpod) | Render | `pharma-lms-api.onrender.com` |
| Database (PostgreSQL) | Render | Managed PostgreSQL 15 |

---

## Quick Start - First Time Setup

### 1. GitHub Repository Setup

```bash
# Ensure your code is pushed to GitHub
git add .
git commit -m "Add CI/CD workflows and deployment configs"
git push origin main
```

### 2. Render Setup (Backend + Database)

1. **Create Render Account**: Go to [render.com](https://render.com) and sign up

2. **Connect GitHub**: Link your GitHub repository

3. **Create Blueprint** (Recommended):
   - Go to **Dashboard → Blueprints → New Blueprint Instance**
   - Select your repository
   - Render will read `render.yaml` and create:
     - `pharma-lms-api` (Web Service)
     - `pharma-lms-db` (PostgreSQL Database)

4. **Manual Setup** (Alternative):
   
   **Create PostgreSQL Database:**
   - Dashboard → New → PostgreSQL
   - Name: `pharma-lms-db`
   - Database: `pharma_lms`
   - Region: Oregon (or nearest)
   - Plan: Starter ($7/month) or Free
   
   **Create Web Service:**
   - Dashboard → New → Web Service
   - Connect your repository
   - Name: `pharma-lms-api`
   - Root Directory: `pharma_lms/pharma_lms_server`
   - Runtime: Docker
   - Dockerfile Path: `Dockerfile.render`
   - Add environment variables (see below)

5. **Environment Variables for Render:**
   ```
   SERVERPOD_DATABASE_HOST=<from database connection>
   SERVERPOD_DATABASE_PORT=5432
   SERVERPOD_DATABASE_NAME=pharma_lms
   SERVERPOD_DATABASE_USER=<from database connection>
   SERVERPOD_DATABASE_PASSWORD=<from database connection>
   SERVERPOD_RUN_MODE=production
   SERVERPOD_REDIS_ENABLED=false
   JWT_SECRET=<generate a strong secret>
   CORS_ALLOWED_ORIGINS=https://pharma-lms.vercel.app
   ```

6. **Get your API URL**: After deployment, copy the URL (e.g., `https://pharma-lms-api.onrender.com`)

### 3. Vercel Setup (Frontend)

1. **Create Vercel Account**: Go to [vercel.com](https://vercel.com) and sign up

2. **Import Project**:
   - Dashboard → Add New → Project
   - Import your GitHub repository
   - Framework Preset: Other
   - Root Directory: Leave empty (we deploy from build/web)

3. **Configure Build Settings**:
   ```
   Build Command: cd pharma_lms/pharma_lms_flutter && flutter build web --release
   Output Directory: pharma_lms/pharma_lms_flutter/build/web
   Install Command: (leave empty - GitHub Action handles this)
   ```

4. **Environment Variables for Vercel**:
   ```
   PRODUCTION_API_URL=https://pharma-lms-api.onrender.com/
   ```

5. **Get Vercel Credentials for GitHub Actions**:
   ```bash
   # Install Vercel CLI
   npm i -g vercel
   
   # Login and link project
   vercel login
   vercel link
   
   # Get project ID and org ID from .vercel/project.json
   cat .vercel/project.json
   ```

### 4. GitHub Secrets Setup

Go to **Repository → Settings → Secrets and variables → Actions** and add:

| Secret | Description | Where to get |
|--------|-------------|--------------|
| `VERCEL_TOKEN` | Vercel API token | Vercel → Settings → Tokens |
| `VERCEL_ORG_ID` | Vercel organization ID | `.vercel/project.json` |
| `VERCEL_PROJECT_ID` | Vercel project ID | `.vercel/project.json` |
| `RENDER_API_KEY` | Render API key | Render → Account Settings → API Keys |
| `RENDER_SERVICE_ID` | Render service ID | Render → Service → Settings → ID |
| `PRODUCTION_API_URL` | Backend API URL | `https://pharma-lms-api.onrender.com/` |

---

## CI/CD Workflows

### Automatic Deployments

| Trigger | Workflow | Action |
|---------|----------|--------|
| Push to `main` (flutter changes) | `flutter-web-deploy.yml` | Build & deploy to Vercel |
| Push to `main` (server changes) | `backend-deploy.yml` | Test, build & deploy to Render |
| Manual dispatch | `database-migrations.yml` | Run database migrations |

### Manual Actions

**Run Database Migrations:**
- Go to **Actions → Run Database Migrations → Run workflow**
- Select environment: `staging` or `production`

**Force Redeploy:**
- Go to **Actions → Select workflow → Run workflow**

---

## Local Development

### Config Files

| File | Purpose | Tracked |
|------|---------|---------|
| `config.json` | Default/development | ✅ Yes |
| `config.local.json` | Local overrides | ❌ No |
| `config.staging.json` | Staging environment | ✅ Yes |
| `config.production.json` | Production reference | ✅ Yes |

### Switching Environments Locally

```bash
# Development (local backend)
echo '{"apiUrl": "http://localhost:8080/"}' > assets/config.json

# Staging
cp assets/config.staging.json assets/config.json

# Production
cp assets/config.production.json assets/config.json
```

---

## Monitoring & Debugging

### Render Dashboard
- View logs: Service → Logs
- View metrics: Service → Metrics
- Connect to DB: Database → Connect → External Connection

### Vercel Dashboard
- View deployments: Project → Deployments
- View analytics: Project → Analytics
- View logs: Deployment → Functions

### Health Checks

```bash
# Check API health
curl https://pharma-lms-api.onrender.com/

# Expected response: OK <timestamp>
```

---

## Cost Estimation

| Service | Plan | Monthly Cost |
|---------|------|--------------|
| Vercel (Frontend) | Hobby | Free |
| Render (API) | Starter | $7 |
| Render (PostgreSQL) | Starter | $7 |
| **Total** | | **$14/month** |

*Note: Free tiers available but have cold start delays and limited resources.*

---

## Troubleshooting

### Common Issues

**1. CORS Errors**
```
Add your frontend URL to CORS_ALLOWED_ORIGINS on Render
```

**2. Database Connection Failed**
```
Check SERVERPOD_DATABASE_* environment variables match Render DB credentials
```

**3. Build Failed on Vercel**
```
Ensure Flutter SDK is available - check workflow logs
```

**4. Cold Start on Render (Free Tier)**
```
Free tier services sleep after 15 min inactivity. 
First request may take 30-60 seconds.
Upgrade to Starter plan for always-on.
```

---

## Security Checklist

- [ ] All secrets stored in GitHub Secrets / Platform env vars
- [ ] `passwords.yaml` not committed to git
- [ ] Database SSL enabled (`requireSsl: true`)
- [ ] CORS restricted to known domains
- [ ] JWT_SECRET is a strong random value
- [ ] No sensitive data in client-side config

---

## Support

For issues with this deployment:
1. Check GitHub Actions logs
2. Check Render/Vercel deployment logs
3. Open an issue on the repository
