apt-get update
apt-get install -y --no-install-recommends software-properties-common jsonlite

curl -fsSL https://deb.nodesource.com/setup_16.x | bash
apt-get install -y nodejs

curl -fsSL https://code-server.dev/install.sh | sh

mkdir ~/.vscode-server/extensions -p
export EXTENSIONS_DIR=~/.vscode-server/extensions

Rscript -e 'install.packages("languageserver")'

code-server --extensions-dir $EXTENSIONS_DIR --install-extension ms-python.python
code-server --extensions-dir $EXTENSIONS_DIR --install-extension ms-python.debugpy
code-server --extensions-dir $EXTENSIONS_DIR --install-extension reditorsupport.r
code-server --extensions-dir $EXTENSIONS_DIR --install-extension rdebugger.r-debugger
code-server --extensions-dir $EXTENSIONS_DIR --install-extension quarto.quarto
code-server --extensions-dir $EXTENSIONS_DIR --install-extension ms-toolsai.jupyter