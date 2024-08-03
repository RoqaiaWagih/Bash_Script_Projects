#!/bin/bash


# Function to move files 
move_files() {
  local EXT=$1
  shift
  local FILES=("$@")

  if [ "${#FILES[@]}" -gt 0 ]; then
    mkdir -p "$EXT"
    for FILE in "${FILES[@]}"; do
      mv "$FILE" "$EXT/"
    done
  fi
}

# Function to organize files 
organize_files() {
  local DIR_PATH=$1

  cd "$DIR_PATH" || exit
  ##local FILES=(*)
  declare -a FILES

  declare -a TXT_FILES
  declare -a JPG_FILES
  declare -a PDF_FILES
  declare -a MISC_FILES

  for FILE in "${FILES[@]}"; do
    if [ -d "$FILE" ]; then
      continue
    fi

    EXT="${FILE##*.}"
    if [[ "$FILE" == *.* ]]; then
      case "$EXT" in
        txt) TXT_FILES+=("$FILE") ;;
        jpg) JPG_FILES+=("$FILE") ;;
        pdf) PDF_FILES+=("$FILE") ;;
        *) MISC_FILES+=("$FILE") ;;
      esac
    else
      MISC_FILES+=("$FILE")
    fi
  done

  move_files "txt" "${TXT_FILES[@]}"
  move_files "jpg" "${JPG_FILES[@]}"
  move_files "pdf" "${PDF_FILES[@]}"
  move_files "misc" "${MISC_FILES[@]}"
}

# Main script execution
main() {
  organize_files "$1"
  echo "Files have been organized."
}

# Run the main function with the provided argument
main "$1"
