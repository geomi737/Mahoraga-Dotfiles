#!/usr/bin/env python3
import subprocess

subprocess.run(["killall", "waybar"])
subprocess.run(["waybar"])
