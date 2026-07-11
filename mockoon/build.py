#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Пересобрать mockoon.json одной командой: python3 build.py"""
import subprocess, os, sys
here = os.path.dirname(os.path.abspath(__file__))
for step in ("gen_mockoon.py", "build_env.py"):
    subprocess.run([sys.executable, os.path.join(here, step)], check=True)
