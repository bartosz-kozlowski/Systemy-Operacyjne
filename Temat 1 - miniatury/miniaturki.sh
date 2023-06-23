#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Nie podano żadnych katalogów."
    exit 1
fi

for dir in "$@"
do
    if [ ! -d "$dir" ]; then
        echo "Nie istnieje katalog "$dir"."
        continue
    fi

    for file in "$dir"/*
    do
        mimetype=$(file --mime-type -b "$file")
        if [[ $mimetype != image/* ]]
        then
            continue
        fi

        tn_dir="$dir/tn"
        mkdir -p "$tn_dir"

        tn_file="$tn_dir/$(basename "$file")"
        convert "$file" -resize 200x200 "$tn_file"

        touch -r "$file" "$tn_file"

        echo "$file" został przetworzony.
    done
done

