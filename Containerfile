FROM registry.fedoraproject.org/fedora-toolbox:43

LABEL name="devbox"

COPY extra-packages /

RUN dnf -y install $(<extra-packages)

RUN rm /extra-packages
RUN dnf clean all

