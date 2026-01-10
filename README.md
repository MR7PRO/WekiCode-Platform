# WekiCode Platform — Assignments #2 & #3 (Docker, GitHub, CI, Production)

A Dockerized web platform built with **React + Vite + TypeScript**, served in production using **Nginx**, integrated with **Supabase**, and documented for:
- **Assignment 2:** Docker + Git/GitHub + CI (Bonus)
- **Assignment 3:** Production deployment on **ClawCloud Run**

---

## 🔗 Live Links

- **Netlify (Web Hosting):**
  - https://wekicode-platform.netlify.app/
- **ClawCloud Run (Production / VPS-style deployment):**
  - https://vbtsoeieqabg.us-east-1.clawcloudrun.com
- **GitHub Repository:**
  - https://github.com/MR7PRO/WekiCode-Platform.git
- **YouTube Demo:**
   <video src="[VIDEO_URL](https://www.youtube.com/watch?v=6VVxQGgiiug)" controls playsinline></video>


---

## 🧠 Project Overview

WekiCode is a learning platform concept that provides:
- A clean landing + courses browsing experience
- Authentication & database integration via Supabase
- A responsive UI with modern UX
- A production-ready Nginx deployment
- A `/health` endpoint for smoke testing and CI checks

---

## ✨ Key Features (from the platform)

- **Modern UI** (React + TypeScript + Vite)
- **Responsive design** for desktop/mobile
- **Supabase integration** (Auth + database)
- **PWA-ready** assets (icons/manifest)
- **Nginx production serving** (static build)
- **Health endpoint** for monitoring and CI:
  - `GET /health` → returns JSON `{ "status": "ok" }`
- **Dev / Ops Quality**
  - Docker multi-stage build
  - Docker Compose
  - GitHub Actions CI (Docker build + run + smoke test)
  - Helpful scripts for Windows users

---

## 🧰 Tech Stack

- Frontend: React, TypeScript, Vite
- Backend-as-a-Service: Supabase
- Production server: Nginx
- DevOps: Docker, Docker Compose, GitHub Actions
- Deployment: Netlify + ClawCloud Run

---

## ✅ Quick Start (Local Development)

### 1) Install dependencies
Use one of the following (depending on your setup):
```bash
npm install
# or
bun install
```

-### Prerequisites
- Docker Desktop installed and running
- Git installed

-### 1) Clone the repository
```bash
git clone https://github.com/MR7PRO/WekiCode-Platform.git
cd WekiCode-Platform
```

-### 2) Environment variables (Supabase)

This project uses Vite variables (client-side).
To run quickly, you can use these values directly (public anon key):

Create a file named .env in the project root:
```bash
VITE_SUPABASE_PROJECT_ID="epajjiiuaqjieecvmpln"
VITE_SUPABASE_PUBLISHABLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVwYWpqaWl1YXFqaWVlY3ZtcGxuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYzMDk2MzIsImV4cCI6MjA4MTg4NTYzMn0.J9X8OXVHC2vTOVFixckZM3so1R3whJe0Gs-WZfQ758M"
VITE_SUPABASE_URL="https://epajjiiuaqjieecvmpln.supabase.co"

Notes:

* "These are client/public values used by the frontend (anon key)."

* "Do NOT commit secret/service-role keys to GitHub."
```

 -### 3) Run using Docker Compose (recommended)
Option A — Windows (PowerShell)

From project root:
```bash
powershell -ExecutionPolicy Bypass -File .\scripts\dev.ps1
```

Option B — Linux/macOS (Makefile)
```bash
make up
```

Option C — If you don’t have make
```bash
docker compose up -d --build
```

-###4) Open the app
* App: http://localhost:8080
* Health: http://localhost:8080/health
 → should return OK

 🧪 How to Test
 -Local
 * Open: http://localhost:8080
 * Health endpoint: http://localhost:8080/health
 -Production (ClawCloud Run)
 * Open: https://vbtsoeieqabg.us-east-1.clawcloudrun.com/

 🛑 Stop the container & Clean up
 * Windows (PowerShell) vs teminal : 
```bash
powershell -ExecutionPolicy Bypass -File .\scripts\down.ps1
```
 * Linux/macOS (Makefile)
```bash
make down
```
 * Manual (Docker Compose)
```bash
docker compose down --rmi local --volumes --remove-orphans
```

 -###🐳 Build & Push Docker Image (Assignment #3 - Production)
 The following commands match what was used during the assignment (PowerShell multi-line style).
 * 1) Docker login

    ```bash
    docker login
    ```

 * 2) Build image (PowerShell style)

    ```bash
    docker build `
      --no-cache `
      --build-arg VITE_SUPABASE_URL="https://epajjiiuaqjieecvmpln.supabase.co" `
      --build-arg VITE_SUPABASE_PUBLISHABLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVwYWpqaWl1YXFqaWVlY3ZtcGxuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYzMDk2MzIsImV4cCI6MjA4MTg4NTYzMn0.J9X8OXVHC2vTOVFixckZM3so1R3whJe0Gs-WZfQ758M" `
      --build-arg VITE_SUPABASE_PROJECT_ID="epajjiiuaqjieecvmpln" `
      -t mr7pro/wekicode-platform:clawcloud-a3-v1 .
    ```

  * 3) Push image to Docker Hub

    ```bash
    docker push mr7pro/wekicode-platform:clawcloud-a3-v1
    ```

 -###☁️ Deploy on ClawCloud Run (Assignment #3)
High level steps (as documented in screenshots/PDF):

1-Open App Launchpad → Deploy Application

2- Set Application Name

3- Choose Public Image

4- Image name:

mr7pro/wekicode-platform:clawcloud-a3-v1

5-Configure port/exposure in the UI (as shown in screenshots)

6- Deploy → get the public URL

Production URL:

* https://vbtsoeieqabg.us-east-1.clawcloudrun.com/

🤖 CI (Bonus B) — GitHub Actions

Workflow file:

.github/workflows/ci.yml

What it does:

* Builds Docker image

* Runs container on port 8080

* Calls /health with retry

* Fails the pipeline if health check fails

-###📁 Project Structure

* Dockerfile → multi-stage build (build with Bun, serve with Nginx)

* docker-compose.yml → local container orchestration

* nginx.conf → includes /health endpoint

* scripts/ → PowerShell helpers for Windows

* docs/screenshots/ → assignment evidence screenshots

* docs/notes.md → technical note (required)

-###🧯 Troubleshooting (common issues we solved)

*Windows: make not recognized

*Use scripts/*.ps1 (PowerShell) instead of Makefile.

*PowerShell curl -fsS fails

*PowerShell aliases curl to Invoke-WebRequest.

* Use scripts/health.ps1 or curl.exe.

* Blank page after deployment

* Ensure Docker image is built with required Vite build args.

* Validate Nginx is serving correct dist/ output.

📸 Evidence (Screenshots)

*All screenshots are provided under:

* docs/screenshots/
and also included in the submission PDF.

Typical evidence includes:

* Local run + Docker compose build/run + health check

* Dockerfile multi-stage build

* GitHub Actions CI run (green)

* Docker Hub push

* ClawCloud deployment + production URL working

