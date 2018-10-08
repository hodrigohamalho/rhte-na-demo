FROM centos/s2i-base-centos7

COPY ./bin/jq /usr/local/bin/
COPY ./run.sh /tmp/run.sh

USER 1001

CMD bash /tmp/run.sh
