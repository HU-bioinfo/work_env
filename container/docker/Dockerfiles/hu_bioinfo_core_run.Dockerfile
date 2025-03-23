FROM kokeh/hu_bioinfo:core

COPY /scripts/.Rprofile $R_PROFILE
COPY /scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

USER user
WORKDIR /home/user/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]