#!/bin/bash

while true; do
    # Получаем активное окно
    active_class=$(hyprctl activewindow | grep -oP 'class: \K.*')
    
    # Выводим в консоль
    echo "Active window class: $active_class"

    # Ждём 1 секунду
    sleep 1
done