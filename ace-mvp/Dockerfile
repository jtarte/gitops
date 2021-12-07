FROM cp.icr.io/cp/appc/ace-server-prod:12.0.2.0-r1-20211019-145438-amd64

USER root
COPY TEST.bar /home/aceuser/bars/TEST.bar
RUN  chmod -R ugo+rwx /home/aceuser

USER 1000

RUN ace_compile_bars.sh

USER root
RUN  chmod -R ugo+rwx /home/aceuser
USER 1000




