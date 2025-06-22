#!/usr/bin/env python3
import subprocess

# Пункты меню
options = ["Reset", "Shutdown"]

# Вызов rofi
rofi = subprocess.run(
    ["rofi", "-dmenu", "-p", "Power Menu"],
    input="\n".join(options),
    text=True,
    capture_output=True
)

choice = rofi.stdout.strip()

# Обработка выбора
if choice == "Shutdown":
    subprocess.run(["systemctl", "poweroff"])
    # subprocess.run(["pkill", "-f", "sing-box"])
    # или subprocess.run(["systemctl", "stop", "sing-box"])
elif choice == "Reset":
    subprocess.run(["systemctl", "reboot"])
    # subprocess.run(["pkill", "-f", "sing-box"])
    # subprocess.run(["sleep", "0.5"])
    # subprocess.run(["/путь/к/sing-box", "-config", "конфиг.json"])
else:
    pass
