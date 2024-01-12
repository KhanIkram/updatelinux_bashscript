# Author: Ikram Khan
# v1.0 - 12/11/23 
# v1.1 - 01/12/24 - added some comments and modified code. 

#!/bin/bash

# Define color codes for better output visualization. We use single quotes for color to avoid unnecessary interpretation
# of escape characters.
RED='\033[1;31m'
GREEN='\033[1;32m'
NOCOLOR='\033[0m'

# Function to display step information
print_step() {
  echo -e "step $1: ${GREEN}$2${NOCOLOR}"
}

# Function to execute commands with error handling. This ensures that the script exits if any command fails.
execute_command() {
  if ! "$@"; then
    echo -e "${RED}Error executing: $@${NOCOLOR}" >&2
    exit 1
  fi
}

# Combined similar steps into an array for better organization. 
steps=(
  "sudo dpkg --configure -a"                                    # Step 1: Pre-configuring packages
  "sudo apt-get install -f"                                     # Step 2: Fix and attempt to correct a system with broken dependencies
  "sudo apt-get update"                                          # Step 3: Update apt cache
  "sudo apt-get upgrade"                                         # Step 4: Upgrade packages
  "sudo apt-get dist-upgrade"                                    # Step 5: Distribution upgrade
  "sudo apt-get --purge autoremove"                              # Step 6: Remove unused packages
  "sudo apt-get autoclean"                                       # Step 7: Clean up
)

# Loop through steps and execute commands. The looping through the steps array above helps reduce repetitive code.
for ((i = 0; i < ${#steps[@]}; i++)); do
  print_step "$((i + 1))" "${steps[i]#* }"  # Extract command for cleaner output
  execute_command ${steps[i]}
done

# Additional newline for better visual separation
echo
