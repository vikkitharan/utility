#!/bin/bash
if [ $# == 1 ]; then
  TAG_FILE=$1
  TITLE=$( echo ${TAG_FILE} | sed 's/^tags_\(.*\)$/\1/g' )
  LIST_FILE="files_"${TITLE}".txt"
  echo -e '\033k'${TITLE}'\033\\'
  nvim -c "set tag=${TAG_FILE}" -c "let g:FileName=\"${LIST_FILE}\""
else
  echo "Argument error"
  echo "Usage: $0 <tag_file>"
fi
