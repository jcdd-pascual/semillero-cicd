#!/usr/bin/env sh
set -eu
GRADLE_VERSION="8.14.3"
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
CACHE="$ROOT/.gradle-dist"
GRADLE_HOME_LOCAL="$CACHE/gradle-$GRADLE_VERSION"
ZIP="$CACHE/gradle-$GRADLE_VERSION-bin.zip"

if [ ! -x "$GRADLE_HOME_LOCAL/bin/gradle" ]; then
  echo "[semillero-cicd] Descargando Gradle $GRADLE_VERSION por primera vez..."
  mkdir -p "$CACHE"
  curl -fsSL "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -o "$ZIP"
  unzip -q -o "$ZIP" -d "$CACHE"
  rm -f "$ZIP"
fi

exec "$GRADLE_HOME_LOCAL/bin/gradle" "$@"
