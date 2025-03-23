#!/bin/bash
Rscript -e "library(IRkernel)" -e "IRkernel::installspec(name = 'R')"

parent_dir="/home/user/wd/proj"
string="ipython"

# .vscodeフォルダを除いたサブフォルダを探してループ
find "$parent_dir" -mindepth 1 -maxdepth 1 -type d ! -name ".vscode" | while read -r dir; do
    folder_name=$(basename "$dir")
    file="$dir/uv.lock"  # 各サブフォルダの対象ファイル名を指定
    
    if [ -f "$file" ]; then
        if grep -q "$string" "$file"; then
            echo "[$dir] setup ipykernel"

            cd $dir
            uv run ipython kernel install --user --name=$folder_name-py
        else
            echo "[$dir] ipykernel isn't installed."
        fi
    else
        echo "[$dir] Doesn't have uv.lock."
    fi
done
