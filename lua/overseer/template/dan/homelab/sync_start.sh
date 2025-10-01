#!/usr/bin/env bash
set -euo pipefail

NAME="raspi-services"
HOST="raspi.services"                                  
LOCAL="${HOME}/Projects/remote/raspi/services"        
REL_UNDER_HOME="services"                            

mkdir -p "$LOCAL"

REMOTE_HOME="$(command ssh "$HOST" 'printf %s "$HOME"')" || {
  echo "[mutagen] ERROR: failed to resolve remote \$HOME via SSH ($HOST)" >&2
  exit 1
}
REMOTE="${HOST}:${REMOTE_HOME%/}/${REL_UNDER_HOME}"

if mutagen sync list -q "$NAME" >/dev/null 2>&1; then
  echo "[mutagen] resuming session: $NAME"
  mutagen sync resume "$NAME"
else
  echo "[mutagen] creating session: $NAME"
  mutagen sync create \
    --name "$NAME" \
    --sync-mode=two-way-safe \
    "$LOCAL" "$REMOTE"
fi

mutagen sync list "$NAME"
mutagen sync monitor "$NAME"
