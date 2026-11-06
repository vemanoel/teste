# pornhub-tv

An unofficial client that brings Pornhub to Amazon Fire TV devices.

## Features

- TODO

## Installation

1. [Install Downloader app on your FireTV](https://troypoint.com/downloader-1-2)
2. Open the Downloader app and search by the code 

## Development

### Prerequisites

Make sure that following tools are installed on your machine:

- [just](https://just.systems/man/en/packages.html)
- [podman](https://podman.io/docs/installation)
- [podman-compose](https://github.com/containers/podman-compose#installation)

### Environment setup

1. Make sure your computer and Fire TV are connected to the same Wi-Fi network
2. Select **Settings** > **My Fire TV** > **About** and Repeatedly press the Enter button  
  on your remote until a notification confirms that Developer Options have been enabled
4. Navigate to **Settings** > **My Fire TV** > **Developer Options**, select **ADB Debugging**, press  
   the Enter button on your remote, a prompt will appear asking: **"Allow wireless debugging  
   on this network?"**, check the box **"Always allow on this network"**, select **Allow** and press  
   the Enter button on your remote
6. Select **Settings** > **My Fire TV** > **About** > **Network** and find your Fire TV's IP Address
7. On your computer, open a terminal in the project root directory and run:
    ```bash
    make up
    make connect-firetv
    ```
8. A prompt will appear on your Fire TV asking: **"Allow USB debugging?"**. Check the box  
   **"Always allow from this computer"**, select **Allow** and press the Enter button on your remote

### Running

1. If you are not connected to the device, run:
    ```bash
    make up
    make connect-firetv
    ```
1. If this is the first time you're running this, or if a file within the Android folder has been modified, run this command:
    ```bash
    make install
   ```
1. Open the app on your firetv
2. Open a terminal in the project root directory and run:
    ```bash
    make start
    ```
2. Open the TVApp
