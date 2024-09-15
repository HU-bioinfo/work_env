#!/bin/bash

# ベースとなるディレクトリ（ここではカレントディレクトリ）
proj_dir="/home/proj"

# scripts フォルダのパス
scripts_dir="$proj_dir/scripts"

# ベースディレクトリ内のすべてのディレクトリを検索
find "$proj_dir" -mindepth 1 -maxdepth 1 -type d ! -path "$scripts_dir" | while read -r dir; do
    echo "Processing directory: $dir"
    cd $dir
    
    proj_name=$(basename $dir)
    poetry run ipython kernel install --user --name="Python-$proj_name" --display-name "Python-$proj_name"
    poetry run poe loadRkernel
    
    cd /home/proj
done
