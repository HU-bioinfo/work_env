curl https://pyenv.run | bash

eval "$(pyenv init -)"

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

curl -sSL https://install.python-poetry.org | python3 - 
