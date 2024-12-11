
# Function to display files in the 'systems' subdirectory and let the user select one
select_file_from_systems() {
    local subdir="systems"

    if [[ -d "$subdir" ]]; then
        # List files with numbering
        files=("$subdir"/*) # Array of all files in the subdirectory
        for i in "${!files[@]}"; do
            printf "%3d) %s\n" "$((i + 1))" "${files[$i]}"
        done

        echo "Enter the number of the file you want to select:"
        read -r selected_index

        # Validate selection
        if [[ "$selected_index" =~ ^[0-9]+$ ]] && ((selected_index >= 1 && selected_index <= ${#files[@]})); then
            selected_file="${files[$((selected_index - 1))]}"
            echo "\nYou selected: $selected_file"
        else
            echo "Invalid selection: $selected_index"
            return 1
        fi

        # Save selected file to a variable
        SELECTED_FILE="$selected_file"
    else
        echo "Subdirectory '$subdir' does not exist."
        return 1
    fi
}

# Call the function
select_file_from_systems

cp ./config/guix/channels.scm /etc/guix/channels.scm
guix pull -c 12
guix archive --authorize < ./signing-key.pub
hash guix
herd start cow-store /mnt
guix time-machine -C ./channel-lock.scm -- system init --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org' /mnt/etc/guix-config/system/$SELECTED_FILE /mnt
mkdir -p /mnt/etc/guix
cp ./config/guix/channels.scm /mnt/etc/guix/channels.scm
