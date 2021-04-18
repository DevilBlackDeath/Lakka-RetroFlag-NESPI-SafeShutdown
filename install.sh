#!/bin/bash

# Script Config
TIMEZONE_FILE="/storage/.cache/timezone"
DEFAULT_TIMEZONE="America/Regina"
GIT_NAME="Lakka-RetroFlag-NESPI-SafeShutdown"
MASTER_ARCHIVE_FILE="${GIT_NAME}.zip"
MASTER_ARCHIVE_URL="https://github.com/DevilBlackDeath/${GIT_NAME}/archive/master.zip"
AUTOSTART_SCRIPT="/storage/.config/autostart.sh"
TMP_DIR="/storage/.tmp"
SCRIPT_FOLDER="/storage/scripts"
PYTHON_LAKKASCRIPT_CMD="(cd ${SCRIPT_FOLDER} && python ${SCRIPT_FOLDER}/safe_shutdown.py &)"
GPIO_POWEROFF_CONFIG="dtoverlay=gpio-poweroff,gpiopin=4,active_low=1,input=1"
CONFLICT_README="conflict.txt"
PICONFIG_FILE="/flash/config.txt"

SCRIPT_ABS_LOCATION=dirname -- "$(realpath "$0")"
echo ${SCRIPT_ABS_LOCATION}

# On Lakka the default user id is 0
if ! [ $(id -u) = 0 ]; then
   echo "Please execute script as root (on Lakka this should be the default user)." 
   exit 1
fi

# Set timezone
read -p "Enter your timezone [${DEFAULT_TIMEZONE}]:" USER_TIMEZONE
USER_TIMEZONE=${USER_TIMEZONE:-${DEFAULT_TIMEZONE}}
echo "Using timezone ${USER_TIMEZONE}"
echo "TIMEZONE=${USER_TIMEZONE}" > "${TIMEZONE_FILE}"

# Download scripts
mkdir -p "${TMP_DIR}"
cd "${TMP_DIR}"
wget -O "${MASTER_ARCHIVE_FILE}" "${MASTER_ARCHIVE_URL}"

# Install scripts
unzip -o "${MASTER_ARCHIVE_FILE}"
rm "${MASTER_ARCHIVE_FILE}"
cd ${GIT_NAME}-master/
mkdir -p ${SCRIPT_FOLDER}
mv ./scripts/* ${SCRIPT_FOLDER}

# Set autostart
if ! grep -Fxq "${PYTHON_LAKKASCRIPT_CMD}" "${AUTOSTART_SCRIPT}"; then
    echo "${PYTHON_LAKKASCRIPT_CMD}" >> "${AUTOSTART_SCRIPT}"
fi

# Writing GPIO poweroff informations
mount -o remount, rw /flash
if ! grep -Fxq "${GPIO_POWEROFF_CONFIG}" "${PICONFIG_FILE}"; then
    echo "Setting up overlay configuration for shutdown"
    printf '' '# Overlay setup for proper powercut, needed for Retroflag cases' >> "${PICONFIG_FILE}"
    echo "${GPIO_POWEROFF_CONFIG}" >> "${PICONFIG_FILE}"
fi
mount -o remount,ro /flash

# Check success
if grep -Fxq "${PYTHON_LAKKASCRIPT_CMD}" "${AUTOSTART_SCRIPT}" && grep -Fxq "${GPIO_POWEROFF_CONFIG}" "${PICONFIG_FILE}" && [ -f "${SCRIPT_FOLDER}/safe_shutdown.py" ]; then
    cd "${TMP_DIR}"
    rm -r ${GIT_NAME}-master/
    echo "Success installing scripts."
    echo "Will now reboot after 3 seconds."
    cd "${SCRIPT_ABS_LOCATION}"
    rm $0
    sleep 3
    # reboot
else
	echo "Error installing scripts, autostart configuration failed..."
	echo "Manually write '${PYTHON_LAKKASCRIPT_CMD}' in ${AUTOSTART_SCRIPT}, if this still doesn't work, the script didn't copy properly, please rerun the installation script, as indicated on the project's README. If this still fails, report an issue on the repository with as much details as possible"
fi

