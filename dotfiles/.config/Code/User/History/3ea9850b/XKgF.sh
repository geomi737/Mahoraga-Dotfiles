#!/bin/bash

# Проверяем, существует ли интерфейс
if ip link show | grep -q "amnezia_for_awg"; then
    # Если есть, то выключаем
    echo "VPN "
else
    # Если нет, то включаем
    echo "VPN "
fi
