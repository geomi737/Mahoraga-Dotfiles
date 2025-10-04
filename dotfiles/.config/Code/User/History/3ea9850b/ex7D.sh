#!/usr/bin/env bash

# === Настройки: полные пути ===
AWG_BIN="/usr/sbin/awg-quick"                                      # путь к awg-quick
AWG_CONF="/home/lesh/Документы/awg-quick/amnezia_for_awg.conf"    # путь к конфигу
INTERFACE="amnezia_for_awg"

# === Тексты для Waybar ===
TEXT_UP="VPN Включен"
TEXT_DOWN="VPN Выключен"

# === Проверка интерфейса ===
if ip link show | grep -q "$INTERFACE"; then
    # Если интерфейс есть, то текст для «включено»
    STATUS="$TEXT_UP"
else
    STATUS="$TEXT_DOWN"
fi

# === Если скрипт вызван с кликом (Waybar передаёт событие) ===
if [ "$1" == "click" ]; then
    if ip link show | grep -q "$INTERFACE"; then
        # выключаем
        sudo "$AWG_BIN" down "$AWG_CONF"
        STATUS="$TEXT_DOWN"
    else
        # включаем
        sudo "$AWG_BIN" up "$AWG_CONF"
        STATUS="$TEXT_UP"
    fi
fi

# === Вывод для Waybar ===
echo "$STATUS"
