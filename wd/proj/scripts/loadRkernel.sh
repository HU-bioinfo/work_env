Rscript -e '
library(IRkernel)
dirname <- basename(getwd())
IRkernel::installspec(name = paste0("R-", dirname), displayname = paste0("R-", dirname))
'