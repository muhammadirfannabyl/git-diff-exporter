# git-diff-exporter
Export branches diff files into compressed archive

## Description
This bash script gets a list of changed files between two branches, then export them into compressed archive (.zip).

## Use Case
- Obtaining only changed files between two branches.
- Apply changed file into a working directory not having version control software installed.

The use cases are considered to:
- Simplify manual process of applying changed files into non-version controlled working directory
- Minimise redundancy in updating changed files into working directory
- Prevent entire files containing some unintended and untracked changes to be updated into working directory

## Prerequisite
- Git
- Existing local repository

## Usage
1. Place this script (git-diff-exporter.sh) within the same directory with local repository folder to be exported.
2. Run this script.
3. Enter repository folder name.
4. Enter first branch name to compare.
5. Enter second branch name containing changes based on the first branch.
6. Get compressed files containing the changed file.

## Acknowledgement
This script is produced in addition of AI generation tool Google Gemini as a simple workaround for listed Use Cases above.
