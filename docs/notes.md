# Notes — Assignment 2 & 3 (WekiCode Platform)

Student: Ayham Ayman Al Hor  
Student ID: 120221684  
Repo: https://github.com/MR7PRO/WekiCode-Platform.git

---

## Assignment 2 — Docker & GitHub Basics (Practical)

### What was implemented
- Dockerfile with multi-stage build:
  - Stage 1: Build with Bun + Vite
  - Stage 2: Serve with Nginx
- Docker Compose for local run on `localhost:8080`
- `/health` endpoint via Nginx (`/health` returns JSON)
- Windows PowerShell scripts for easy run:
  - `scripts/dev.ps1`, `scripts/down.ps1`, `scripts/health.ps1`, `scripts/up.ps1`
- Makefile for Unix-like systems
- GitHub Actions CI:
  - Docker build + run + `/health` smoke test with retry
- PR workflow:
  - Work on feature branch → Pull Request → Merge into main
- Release/Tag:
  - v1.0.0 — Assignment 2 Submission

### Commands used (local)

Docker compose:
```bash
docker compose up -d --build
docker compose ps
docker compose down
```

Health check:
```bash
curl http://localhost:8080/health
```

Windows (PowerShell):
```bash
powershell -ExecutionPolicy Bypass -File .\scripts\dev.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\health.ps1
```

Issues encountered & fixes

1. make command not found on Windows PowerShell  
✅ Fix: Added PowerShell scripts in scripts/

2. PowerShell curl -fsS error (Invoke-WebRequest parameter issue)  
✅ Fix: Added scripts/health.ps1 and/or use curl.exe

3. Docker Compose warning about version attribute  
✅ Not critical — can be removed for cleaner output (optional improvement)

-### Assignment 3 — Production Deployment (ClawCloud Run)

-Production URL

https://vbtsoeieqabg.us-east-1.clawcloudrun.com

-Health endpoint

https://vbtsoeieqabg.us-east-1.clawcloudrun.com/health

--What was implemented

* Built production Docker image locally using required Vite build args

* Pushed image to DockerHub

* Deployed the Docker image on ClawCloud Run

* Verified production runs via browser + /health

Commands used (local build & push)
```bash
docker login
docker build --no-cache \
  --build-arg VITE_SUPABASE_URL="..." \
  --build-arg VITE_SUPABASE_PUBLISHABLE_KEY="..." \
  --build-arg VITE_SUPABASE_PROJECT_ID="..." \
  -t mr7pro/wekicode-platform:clawcloud-a3-v1 .

docker push mr7pro/wekicode-platform:clawcloud-a3-v1
```

 - Issues encountered & fixes

 * Blank page after opening ClawCloud URL  
✅ Fix: Re-built the image with correct Vite build args, then re-pushed and redeployed.

 * docker push temporary EOF error  
✅ Fix: Re-try push after stable connection / ensure Docker login is valid.

---

```md
# Technical Notes — Assignment #2 (Docker + Git/GitHub)

## 1) Biggest Docker problem I faced (and how I solved it)

### Problem
The biggest issue was **tooling differences on Windows (PowerShell)** compared to Linux/macOS.
- `make` is not installed by default on Windows, so Makefile commands didn’t run.
- Some curl flags like `-fsS` behave differently in PowerShell.
- Also, because this is a **Vite** app, the Supabase variables must be available at **build time** (not only runtime).

### Solution
I solved it by making the workflow developer-friendly on all OS:
- Added **PowerShell scripts** inside `scripts/` (e.g., `dev.ps1`, `down.ps1`, `health.ps1`) so Windows users can run everything easily.
- Kept a **Makefile** for Linux/macOS users.
- Ensured Supabase variables are provided through `.env` and also passed as **Docker build args** when building images.

Result:
- The project can be started in minutes using `docker compose up -d --build`.
- Health checks are available via `/health` locally and in production.

---

## 2) Most important Git/GitHub lesson I learned

The most important lesson was that **clean history + automation = reliable teamwork**:
- Using **small, meaningful commits** with a consistent structure (conventional commits) makes the timeline readable.
- Using **feature branches + Pull Requests** helps review changes before merging.
- **Tags and Releases** are useful to mark stable versions (e.g., `v1.0.0`).
- **GitHub Actions CI** protects the repository by verifying that Docker build/run works after each push.

In short:  
Git is not only about saving code — it’s about maintaining a clean project history and enabling safe collaboration.
```