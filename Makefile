.ONESHELL:
.SILENT:

export

PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
COMPOSE_FILE ?= compose.yaml
PODMAN_COMPOSE_WARNING_LOGS = false

CI ?= false
VERSION_CODE ?=
VERSION_NAME ?=

up:
	podman compose up --build --detach

down:
	podman compose down

shell:
	podman compose exec development bash

connect-firetv:
	printf "HOST[:PORT]: "
	read -r input
	podman compose exec -T development adb connect $$input

connect-phone:
	printf "HOST[:PORT] [PAIRING CODE]: "
	read -r input
	podman compose exec -T development adb pair $$input

	printf "HOST[:PORT]: "
	read -r input
	podman compose exec -T development adb connect $$input

start:
	podman compose exec development bash -e <<'EOF'
	npm install
	npx expo start
	EOF

install:
	podman compose exec development bash -e <<'EOF'
	npm install
	npx expo run:android --no-bundler
	EOF

build:
	podman compose exec development bash -e <<'EOF'
	export VERSION_CODE=$(VERSION_CODE)
	export VERSION_NAME=$(VERSION_NAME)

	npm install

	cd android
	./gradlew clean
	./gradlew assembleRelease --no-daemon --warning-mode all

	OUTDIR=$${OUTDIR:-$$(pwd)/apks}
	mkdir -p $$OUTDIR
	mv -f app/build/outputs/apk/release/*.apk $$OUTDIR
	EOF
