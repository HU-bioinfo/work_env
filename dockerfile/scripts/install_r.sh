curl -L https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg 
sh -c 'echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list'

apt-get update 
apt-get install -y r-rig 
   
rig add $R_VERSION

Rscript -e 'install.packages("renv")'

mkdir -p /usr/lib/R
echo 'if (!"utils" %in% loadedNamespaces()) {library(utils)} \nif (file.exists("renv.lock")) {renv::load()} \noptions(BioC_mirror = "https://p3m.dev/bioconductor/latest") \noptions(BIOCONDUCTOR_CONFIG_FILE = "https://p3m.dev/bioconductor/latest/config.yaml") \noptions(repos = c(CRAN = "https://p3m.dev/cran/__linux__/bookworm/latest"))\nif ("BiocManager" %in% rownames(installed.packages())) {options(repos = BiocManager::repositories())}' >> /usr/lib/R/.Rprofile    
