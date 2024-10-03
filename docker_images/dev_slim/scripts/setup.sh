mkdir /usr/local/etc/R

Rscript --no-site-file -e 'install.packages("renv", lib="/opt/R/4.4.1/lib/R/library")'

echo '
if (!"utils" %in% loadedNamespaces()) {library(utils)} 

if (file.exists("renv.lock")) {
	renv::load()
  if (!requireNamespace("BiocManager", quietly = T)) renv::install("BiocManager")

  options(
    BioC_mirror = "https://p3m.dev/bioconductor/latest",
    BIOCONDUCTOR_CONFIG_FILE = "https://p3m.dev/bioconductor/latest/config.yaml",
    repos = c(CRAN = "https://p3m.dev/cran/__linux__/bookworm/latest"))

  library(BiocManager)
  options(repos = BiocManager::repositories())
}else{
  library(renv)
  renv::init()
  q()
}
' >> $R_PROFILE

echo 'RENV_CONFIG_AUTOLOADER_ENABLED=FALSE' >> $R_ENVIRON