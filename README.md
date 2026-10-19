# beket-margulan-devops

DevOps Lab 1 — Margulan Beket, group it2-2302, ID 38109.

Workflow: Linux → Git → GitHub → Jenkins → Docker.

## Structure
- `app/` — Python application (shows student info, port 5050)
- `scripts/Beket_Margulan_system.sh` — system information script
- `config/app.conf` — application configuration
- `logs/` — logs (ignored by git)
- `Dockerfile`, `docker-compose.yml`, `Jenkinsfile`

## Run
```bash
./scripts/Beket_Margulan_system.sh
docker build -t beket-margulan-devops .
docker run --name beket-margulan-container -p 5050:5050 beket-margulan-devops
docker compose up -d
```
