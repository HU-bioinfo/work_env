FROM python:3.11 as python-builder
FROM rocker/rstudio:4.4 as r-builder

FROM debian:stable-slim

COPY --from=python-builder /usr/local/bin/ /usr/local/bin/
COPY --from=python-builder /usr/local/lib/ /usr/local/lib/
COPY --from=python-builder /usr/local/include/ /usr/local/include/
COPY --from=python-builder /usr/local/share/ /usr/local/share/
COPY --from=python-builder /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/

COPY --from=r-builder /usr/local/bin/ /usr/local/bin/
COPY --from=r-builder /usr/local/lib/ /usr/local/lib/
COPY --from=r-builder /usr/local/include/ /usr/local/include/
COPY --from=r-builder /usr/local/share/ /usr/local/share/
COPY --from=r-builder /etc/R/ /etc/R/
COPY --from=r-builder /usr/local/lib/R/site-library/ /usr/local/lib/R/site-library/
COPY --from=r-builder /usr/local/lib/R/library/ /usr/local/lib/R/library/

COPY --from=r-builder /var/lib/rstudio-server/ /var/lib/rstudio-server/
COPY --from=r-builder /etc/rstudio/ /etc/rstudio/
COPY --from=r-builder /usr/lib/rstudio-server/ /usr/lib/rstudio-server/

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libblas.so.3 /usr/lib/x86_64-linux-gnu/libblas.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libblas.so.3 /usr/lib/x86_64-linux-gnu/libblas.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libreadline.so.8 /usr/lib/x86_64-linux-gnu/libreadline.so.8
RUN ln -s /usr/lib/x86_64-linux-gnu/libreadline.so.8 /usr/lib/x86_64-linux-gnu/libreadline.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libdeflate.so.0 /usr/lib/x86_64-linux-gnu/libdeflate.so.0
RUN ln -s /usr/lib/x86_64-linux-gnu/libdeflate.so.0 /usr/lib/x86_64-linux-gnu/libdeflate.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libtirpc.so.3 /usr/lib/x86_64-linux-gnu/libtirpc.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libtirpc.so.3 /usr/lib/x86_64-linux-gnu/libtirpc.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libicuuc.so.70 /usr/lib/x86_64-linux-gnu/libicuuc.so.70
RUN ln -s /usr/lib/x86_64-linux-gnu/libicuuc.so.70 /usr/lib/x86_64-linux-gnu/libicuuc.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libicui18n.so.70 /usr/lib/x86_64-linux-gnu/libicui18n.so.70
RUN ln -s /usr/lib/x86_64-linux-gnu/libicui18n.so.70 /usr/lib/x86_64-linux-gnu/libicui18n.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libgomp.so.1 /usr/lib/x86_64-linux-gnu/libgomp.so.1
RUN ln -s /usr/lib/x86_64-linux-gnu/libgomp.so.1 /usr/lib/x86_64-linux-gnu/libgomp.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libopenblas.so.0 /usr/lib/x86_64-linux-gnu/libopenblas.so.0
RUN ln -s /usr/lib/x86_64-linux-gnu/libopenblas.so.0 /usr/lib/x86_64-linux-gnu/libopenblas.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2
RUN ln -s /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libicudata.so.70 /usr/lib/x86_64-linux-gnu/libicudata.so.70
RUN ln -s /usr/lib/x86_64-linux-gnu/libicudata.so.70 /usr/lib/x86_64-linux-gnu/libicudata.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libgfortran.so.5 /usr/lib/x86_64-linux-gnu/libgfortran.so.5
RUN ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.5 /usr/lib/x86_64-linux-gnu/libgfortran.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libkrb5.so.3 /usr/lib/x86_64-linux-gnu/libkrb5.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libkrb5.so.3 /usr/lib/x86_64-linux-gnu/libkrb5.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 /usr/lib/x86_64-linux-gnu/libk5crypto.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 /usr/lib/x86_64-linux-gnu/libk5crypto.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 /usr/lib/x86_64-linux-gnu/libkrb5support.so.0
RUN ln -s /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 /usr/lib/x86_64-linux-gnu/libkrb5support.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libquadmath.so.0 /usr/lib/x86_64-linux-gnu/libquadmath.so.0
RUN ln -s /usr/lib/x86_64-linux-gnu/libquadmath.so.0 /usr/lib/x86_64-linux-gnu/libquadmath.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libkeyutils.so.1 /usr/lib/x86_64-linux-gnu/libkeyutils.so.1
RUN ln -s /usr/lib/x86_64-linux-gnu/libkeyutils.so.1 /usr/lib/x86_64-linux-gnu/libkeyutils.so

###

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 /usr/lib/x86_64-linux-gnu/libsqlite3.so.0
RUN ln -s /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 /usr/lib/x86_64-linux-gnu/libsqlite3.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libssl.so.3 /usr/lib/x86_64-linux-gnu/libssl.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libssl.so.3 /usr/lib/x86_64-linux-gnu/libssl.so

COPY --from=r-builder /usr/lib/x86_64-linux-gnu/libcrypto.so.3 /usr/lib/x86_64-linux-gnu/libcrypto.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.3 /usr/lib/x86_64-linux-gnu/libcrypto.so

COPY --from=r-builder /etc/rstudio/ /etc/rstudio/
COPY --from=r-builder /etc/init.d/ /etc/init.d/