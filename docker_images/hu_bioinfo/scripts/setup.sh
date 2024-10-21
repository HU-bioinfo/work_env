mkdir /usr/local/etc/R

Rscript --no-site-file -e 'install.packages("renv", lib="/opt/R/4.4.1/lib/R/library")'
Rscript --no-site-file -e 'install.packages("languageserver", lib="/opt/R/4.4.1/lib/R/library")'

echo 'RENV_CONFIG_AUTOLOADER_ENABLED=FALSE' >> $R_ENVIRON