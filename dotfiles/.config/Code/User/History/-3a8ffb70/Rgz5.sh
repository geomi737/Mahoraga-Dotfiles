#!/bin/bash

# Проверяем, существует ли интерфейс
if ip link show | grep -q "amnezia_for_awg"; then
    # Если есть, то выключаем
    sudo pxexec awg-quick down ~/Документы/awg-quick/amnezia_for_awg.conf
else
    # Если нет, то включаем
    sudo pxexec awg-quick up ~/Документы/awg-quick/amnezia_for_awg.conf
fi
