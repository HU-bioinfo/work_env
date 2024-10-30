if (!"utils" %in% loadedNamespaces()) {library(utils)} 
if (file.exists("renv.lock")) {
    renv::load()

    library(BiocManager)
    options(
        BioC_mirror = "https://p3m.dev/bioconductor/latest",
        BIOCONDUCTOR_CONFIG_FILE = "https://p3m.dev/bioconductor/latest/config.yaml",
        repos = c(CRAN = "https://p3m.dev/cran/__linux__/bookworm/latest")
    )
    options(repos = BiocManager::repositories())
}
