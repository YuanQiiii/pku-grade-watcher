#!/bin/bash

# 显式地进入脚本所在的工作目录，确保后续命令的相对路径正确
cd /home/xianyu/tasks/pku-grade-watcher || exit

# 使用 Conda 环境中 Python 解释器的绝对路径来执行脚本
# 这样就不再需要 source 或 conda activate，对 cron 非常友好
/home/xianyu/tools/miniconda3/bin/python main.py
