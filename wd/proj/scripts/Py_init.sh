poetry new $1
cd $1

poetry config cache-dir "/home/cache/poetry"
poetry add ipykernel poethepoet pyyaml nbformat nbclient
poetry run ipython kernel install --user --name="Python-$1" --display-name "Python-$1"