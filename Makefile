.ONESHELL:
.SILENT:

export

PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
COMPOSE_FILE ?= compose.yaml
PODMAN_COMPOSE_WARNING_LOGS = false

up:
	podman compose up --build --detach

down:
	podman compose down

shell:
	podman compose exec development bash

setup:
	podman compose exec development bash -e <<'EOF'
	npm install $(NPM_INSTALL_EXTRA_ARGS)
	npx expo prebuild --clean --platform android
	EOF

connect\:firetv:
	printf "[HOST:PORT]: "
	read -r input
	podman compose exec -T development adb connect $$input

connect\:phone:
	printf "[HOST:PORT] [PAIRING CODE]: "
	read -r input
	podman compose exec -T development adb pair $$input

	printf "[HOST:PORT]: "
	read -r input
	podman compose exec -T development adb connect $$input

serve:
	podman compose exec development npx expo start

launch:
	podman compose exec development npx expo run:android

build:
	podman compose exec development bash -e <<'EOF'
	export VERSION_NAME=$(VERSION_NAME)
	export VERSION_CODE=$(VERSION_CODE)

	cd android
	./gradlew clean
	./gradlew :app:assembleRelease --no-daemon --warning-mode=all

	OUTDIR=$${OUTDIR:-$$(pwd)/apks}
	mkdir -p $$OUTDIR
	mv -f app/build/outputs/apk/release/*.apk $$OUTDIR
	EOF
