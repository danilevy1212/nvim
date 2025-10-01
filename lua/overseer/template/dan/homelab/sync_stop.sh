#!/usr/bin/env bash
set -euo pipefail

NAME="raspi-services"
HOST="raspi.services"
LOCAL="${HOME}/Projects/remote/raspi/services"
REL_UNDER_HOME="services"

if mutagen sync list "$NAME" >/dev/null 2>&1; then
	echo "[mutagen] terminating session: $NAME"
	mutagen sync terminate "$NAME"
fi

sessions_using_local=$(mutagen sync list --template '{{range .}}{{.Alpha.Path}}{{"\n"}}{{.Beta.Path}}{{"\n"}}{{end}}' 2>/dev/null | grep -Fx "$LOCAL" | wc -l || true)

if [ "$sessions_using_local" -eq 0 ] && [ -d "$LOCAL" ]; then
	echo "[mutagen] no sessions using $LOCAL, cleaning directory contents"
	rm -rf "${LOCAL:?}"/{*,.[!.]*}
else
	echo "[mutagen] $sessions_using_local session(s) still using $LOCAL, keeping directory contents"
fi
