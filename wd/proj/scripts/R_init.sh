if [ ! -d $1 ]; then
    mkdir $1
fi
cd $1
Rscript -e 'renv::init()'
Rscript -e '
renv::install(c("BiocManager", "languageserver", "IRkernel", "knitr", "rmarkdown"))
'

CONTENT='[tool.poe.tasks]
loadRkernel.shell = "loadrkernel.sh"
'
echo "$CONTENT" >> pyproject.toml

poetry run poe loadRkernel
