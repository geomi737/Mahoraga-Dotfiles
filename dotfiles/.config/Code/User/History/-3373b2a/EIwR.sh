#!/bin/bash

# Папка с обоями
DIR="$HOME/Wallpapers"

# Файл, где хранится текущая позиция
INDEX_FILE="$HOME/.cache/current_wall_index"

# Получаем список файлов (jpg/png)
mapfile -t FILES < <(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort)

COUNT=${#FILES[@]}
[ $COUNT -eq 0 ] && exit 1

# Загружаем текущий индекс или ставим 0
if [ -f "$INDEX_FILE" ]; then
    INDEX=$(<"$INDEX_FILE")
else
    INDEX=0
fi

# Определяем действие
if [ "$1" == "prev" ]; then
    INDEX=$(( (INDEX - 1 + COUNT) % COUNT ))
else
    INDEX=$(( (INDEX + 1) % COUNT ))
fi

# Сохраняем индекс
echo $INDEX > "$INDEX_FILE"

# Меняем обои и тему
matugen image "${FILES[$INDEX]}" -m dark
