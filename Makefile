export

PODMAN_COMPOSE_PROVIDER ?= $(shell command -v podman-compose)
COMPOSE_FILE ?= compose.yaml
PODMAN_COMPOSE_WARNING_LOGS = false

ORG_GRADLE_PROJECT_VERSION_CODE ?= 0
ORG_GRADLE_PROJECT_VERSION_NAME ?= 0.0.0

.ONESHELL:
.SILENT:

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
	podman compose exec development npx expo start

install:
	podman compose exec -T development npx expo run:android --no-bundler

build:
	podman compose exec -T development bash -e <<'EOF'
	export ORG_GRADLE_PROJECT_VERSION_CODE=$(VERSION_CODE)
	export ORG_GRADLE_PROJECT_VERSION_NAME=$(VERSION_NAME)

	npm install

	cd android
	./gradlew clean
	./gradlew assembleRelease --no-daemon --warning-mode all

	OUTDIR=$${OUTDIR:-$$(pwd)/apks}
	mkdir -p $$OUTDIR
	mv -f app/build/outputs/apk/release/*.apk $$OUTDIR
	EOF
