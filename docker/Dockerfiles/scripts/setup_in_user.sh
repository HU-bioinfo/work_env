uv python install $PYTHON_VERSION

Rscript --no-site-file -e "
    install.packages('renv')
    install.packages('languageserver')
    install.packages('IRkernel')
    install.packages('BiocManager')
    "