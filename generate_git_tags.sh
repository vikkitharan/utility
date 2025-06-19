#!/bin/bash

# Exit on error
set -e

# Print the command
set -x

usage() {
    echo "Usage:"
    echo "  $0 ls    # Run only step 1"
    echo "  $0 tag   # Run from step 2 onwards"
    echo "  $0       # Run all steps"
    exit 1
}

# Step 1: Generate list of version-controlled files
step1() {
    git ls-files > files_git.txt
}

# Step 2: Run operate.sh on each file
step2() {
    cat files_git.txt | ~/utility/Operate.sh file > operated_files.txt
}

# Step 3: Filter output with grep
step3() {
    grep text operated_files.txt > filtered_files.txt
}

# Step 4: Strip everything after the colon using sed
step4() {
    sed 's/:.*//' filtered_files.txt > files_filtered.txt
    mv files_filtered.txt files_git.txt
}

# Step 5: Generate tag file using your Python script
step5() {
    create_tag_file.py files_git.txt
    rm operated_files.txt filtered_files.txt
}

# Main logic
case "$1" in
    ls)
        step1
        echo "Remove files using :g/matching_text/d in nvim then run ./generate_git_tags.sh tag"
        ;;
    tag)
        step2
        step3
        step4
        step5
        ;;
    "")
        step1
        step2
        step3
        step4
        step5
        ;;
    *)
        usage
        ;;
esac
