FROM microbean/base:8
LABEL maintainer="Laird Nelson <ljnelson@microbean.org>" org.microbean.docker.repository.name="microbean/helm"
ARG helmVersion=2.4.1
ENV HELM_VERSION=${helmVersion}
ONBUILD RUN yum install --assumeyes gzip tar && \
yum --assumeyes clean all && \
cd /usr/local/bin && \
curl -S -s https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar -xz --strip-components 1 --transform s/helm/helm-${HELM_VERSION}/ linux-amd64/helm && \
chown root:root helm-${HELM_VERSION} && \
chmod 755 helm-${HELM_VERSION} && \
ln -s helm-${HELM_VERSION} helm && \
helm init --client-only && \
mv /root/.helm /home/microbean/.helm && \
chown -R microbean:microbean /home/microbean/.helm && \
chmod -R 755 /home/microbean/.helm
