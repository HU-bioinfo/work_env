#!/bin/bash

# ベースとなるディレクトリ（ここではカレントディレクトリ）
proj_dir="/home/proj"

# scripts フォルダのパス
scripts_dir="$proj_dir/scripts"

# スクリプトを適用したいシェルスクリプトのパス
script_path="$scripts_dir/rm_proj.sh"

# ベースディレクトリ内のすべてのディレクトリを検索
find "$proj_dir" -mindepth 1 -maxdepth 1 -type d ! -path "$scripts_dir" | while read -r dir; do
    echo "Processing directory: $dir"
    # ここでシェルスクリプトを適用
    bash "$script_path" "$dir"
done
