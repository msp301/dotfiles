FROM registry.fedoraproject.org/fedora-toolbox:43

LABEL name="devbox"

COPY extra-packages /

RUN dnf -y install $(<extra-packages)

# Install 1Password CLI
RUN wget -P /etc/pki/rpm-gpg https://downloads.1password.com/linux/keys/1password.asc
RUN sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
RUN dnf check-update -y 1password-cli && sudo dnf install -y 1password-cli

# Install terraform
RUN wget -P /etc/yum.repos.d https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
RUN dnf -y install terraform

RUN rm /extra-packages
RUN dnf clean all

