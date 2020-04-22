FROM fedora:latest

LABEL maintainer="PnT DevOps Automation - Red Hat, Inc." \
      vendor="PnT DevOps Automation - Red Hat, Inc." \
      summary="Image containing various tools for ansible users and developers" \
      distribution-scope="public"

RUN dnf install -y --setopt=tsflags=nodocs findutils python3 python3-pip git \
    && dnf clean all

RUN pip3 install ansible ansible-lint ansible-tower-cli yamllint yamale

# Force Python requests to use system CA bundle
# https://2.python-requests.org/en/master/user/advanced/#ssl-cert-verification
ENV REQUESTS_CA_BUNDLE "/etc/ssl/certs/ca-bundle.crt"

# Provide way to add user in entrypoint for OpenShift runs
# https://docs.openshift.com/container-platform/3.10/creating_images/guidelines.html#openshift-specific-guidelines
RUN chmod -R g=u /etc/passwd
