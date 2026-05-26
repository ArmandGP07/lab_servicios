#!/bin/bash

REPO_DIR="/hello-express"
BRANCH="deploy"
INTERVALO=30

echo"[autodeploy] Iniciando monitoreo..."

cd "$REPO_DIR" || exit 1

while true; do

	LOCAL=$(git rev-parse HEAD)
	git fetch origin "$BRACH" --quiet
	REMOTO=$(git rev-parse "origin/$BRANCH")

	if [ "$LOCAL" != "$REMOTO" ]; then
		echo "[autoeploy] Cambio detectado, haciendo pull..."
		git pull origin "$BRANCH"
		npm install -- production
		systemctl restart nodeapp
		echo "[autodeploy] App actualizada y reiniciada"
	else
		echo "[autoeploy] Sin cambios $(date '+%H:+%M:+%S')"
	fi

	sleep "$INTERVALO"
done
