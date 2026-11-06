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
	podman compose exec dev bash

setup:
	podman compose exec dev bash -se <<'EOF'
		export VERSION_NAME=$(VERSION_NAME)
		export VERSION_CODE=$(VERSION_CODE)
		export EXPO_NO_GIT_STATUS=1
		npm install
		npx expo prebuild --clean --platform android
	EOF

connect\:firetv:
	printf "[HOST:PORT]: "
	read -r input
	podman compose exec -T dev adb connect $$input

connect\:phone:
	printf "[HOST:PORT] [PAIRING CODE]: "
	read -r input
	podman compose exec -T dev adb pair $$input

	printf "[HOST:PORT]: "
	read -r input
	podman compose exec -T dev adb connect $$input

serve:
	podman compose exec dev npx expo start

launch:
	podman compose exec dev npx expo run:android

build:
	podman compose exec dev bash -se <<'EOF'
		mkdir -p apks
		cd android
		./gradlew clean
		./gradlew :app:assembleRelease --no-daemon
		mv -f app/build/outputs/apk/release/*.apk ../apks
	EOF
