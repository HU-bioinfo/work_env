cd $1
if [ -e "./pyproject.toml" ]; then
    rm -rf /home/cache/poetry/virtualenvs/$(basename $(poetry env list))
fi
cd ..

kernel_dir="/root/.local/share/jupyter/kernels"
py_kernel_dir="$kernel_dir/python-$(basename $1)"
r_kernel_dir="$kernel_dir/r-$(basename $1)"

if [ -d $py_kernel_dir ]; then
    rm -rf $py_kernel_dir
fi
if [ -d $r_kernel_dir ]; then
    rm -rf $r_kernel_dir
fi

rm -rf $1