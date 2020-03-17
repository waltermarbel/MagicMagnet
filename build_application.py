import os
from cx_Freeze import setup, Executable

target = Executable(
    script = "MagicMagnet.py",
    base = "Win32GUI",
    icon = "icon.ico"
)

setup(
    name = "Magic Magnet",
    version = "0.0.1",
    description = "Get magnet links from internet without any effort!",
    author = "Pedro Lemos",
    options = {
        "build_exe": {
            "packages": ["os", "tkinter", "PySimpleGUI", "pyperclip", "requests", "urllib.parse", "bs4", "json"],
            "include_files": ["icon.ico", "icon.png"],
            'include_msvcr': True
        }
    },
    
    executables = [target]
)