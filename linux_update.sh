#!/bin/bash

# Define color codes for better output visualization
RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

# Function to display step information
print_step() {
  echo -e "step $1: ${GREEN}$2${NOCOLOR}"
}

# Function to execute commands with error handling. This ensures that the script exits if any command fails. 
execute_command() {
# The '"$@"' syntax allows the function to handle command-line arguments correctly, ensuring the spaces and special characters are preserved.
  if ! "$@"; then
    echo -e "${RED}Error executing: $@${NOCOLOR}" >&2
    exit 1
  fi
}

# Step 1: Pre-configuring packages
print_step 1 "pre-configuring packages"
execute_command sudo dpkg --configure -a

# Step 2: Fix and attempt to correct a system with broken dependencies
print_step 2 "fix and attempt to correct a system with broken dependencies"
execute_command sudo apt-get install -f

# Step 3: Update apt cache
print_step 3 "update apt cache"
execute_command sudo apt-get update

# Step 4: Upgrade packages
print_step 4 "upgrade packages"
execute_command sudo apt-get upgrade

# Step 5: Distribution upgrade
print_step 5 "distribution upgrade"
execute_command sudo apt-get dist-upgrade

# Step 6: Remove unused packages
print_step 6 "remove unused packages"
execute_command sudo apt-get --purge autoremove

# Step 7: Clean up
print_step 7 "clean up"
execute_command sudo apt-get autoclean

# Additional newline for better visual separation
echo
