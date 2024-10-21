if (!"utils" %in% loadedNamespaces()) {library(utils)} 

if (file.exists("renv.lock")) {
    renv::load()
    if (!requireNamespace("BiocManager", quietly = T)){
        renv::install("BiocManager", prompt=FALSE)
    }

    library(BiocManager)
    options(
        BioC_mirror = "https://p3m.dev/bioconductor/latest",
        BIOCONDUCTOR_CONFIG_FILE = "https://p3m.dev/bioconductor/latest/config.yaml",
        repos = c(CRAN = "https://p3m.dev/cran/__linux__/bookworm/latest")
    )
    options(repos = BiocManager::repositories())
}else{
    current_wd <- getwd()
    base_dir <- "/home/user/wd/proj"

    if (startsWith(current_wd, base_dir) && current_wd != base_dir) {
        library(renv)
        renv::init()
        q()
    }
}