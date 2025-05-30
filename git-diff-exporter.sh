#!/bin/bash

# --- Get the directory where the script is located ---
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

echo "########################################"
echo "##      Git Files Diff Exporter       ##"
echo "##                                    ##"
echo "##       by Nabyl (gen. Gemini)       ##"
echo "########################################"
echo ""
echo "Assuming directory: ${SCRIPT_DIR}"
echo ""

# Check if it's a Git repository
if [ -d  ".git" ]; then
	# get current folder name as repository name
	REPO_NAME=$(basename "$(pwd)")
else
	cd "$SCRIPT_DIR" || { echo "Error: Could not change directory to '$REPO_DIR'. Exiting."; read -p "Press Enter to exit..."; exit 1; }
	while :
	do
		read -p "Enter repository name: " REPO_NAME
		
		# Check if it's a Git repository
		if [ -z "$REPO_NAME" ]; then
			echo ""
			exit 1
		elif [ ! -d  "$REPO_NAME/.git" ]; then
			echo "Error: The specified name is not a Git repository"
			echo "Please try again"
			echo ""
		else
			break
		fi
	done
fi

echo "Repository '$REPO_NAME' selected"
echo ""

read -p "Enter first branch name (e.g. main): " BRANCH1
echo ""

read -p "Enter second branch name (e.g. dev-1): " BRANCH2
echo ""

# --- Generate the current date in the desired format ---
# For Windows Git Bash, 'date' behaves like a Unix command
DATE=$(date +"%d%b%Y_%I%M%p-%s") # e.g., 01Jan2025_0440PM-1700000000

# --- Construct the output zip file name (full path) ---
ZIP_FILE="$REPO_NAME-$DATE.zip"
OUTPUT_ZIP_FULL_PATH="$ZIP_FILE"

# --- Change directory to the repository ---
cd "$REPO_NAME" || { echo "Error: Could not change directory to '$REPO_NAME'. Exiting."; read -p "Press Enter to exit..."; exit 1; }

# --- Execute the git archive command ---
# We use BRANCH2 as the tree-ish for git archive to ensure files are taken from that branch's state
git archive --format=zip --output="../$OUTPUT_ZIP_FULL_PATH" "$BRANCH2" $(git diff --name-only --diff-filter=ACMRT "$BRANCH1" "$BRANCH2")
git diff --name-only --diff-filter=ACMRT "$BRANCH1" "$BRANCH2" > "../${REPO_NAME}_changes-$DATE.txt"

# --- Check the exit status of the git archive command ---
if [ $? -eq 0 ]; then
    echo "Diff archive is saved as '$SCRIPT_DIR/$ZIP_FILE'"
else
    echo "Error: Failed to create the zip archive."
    echo "Please ensure the branch names are correct and there are changes between them, or check the repository path."
fi

# --- Keep the window open if run by double-click ---
echo ""
read -n 1 -s -r -p "Press any key to continue or Ctrl+C to exit..."