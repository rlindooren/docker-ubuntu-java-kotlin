FROM ubuntu:latest

# Install some basic utilities as well as the ZSH shell
RUN apt-get update -y \
    && apt-get install \
       curl \
       wget \
       zip \
       unzip \
       git \
       nano \
       jq \
       tree \
       ssh \
       zsh \
    -y

ARG GROUP=developers
ARG USER=dev

# Create the user and group
RUN groupadd --system --gid 1000 "$GROUP" \
    && useradd --system --gid "$GROUP" --uid 1000 --create-home "$USER"

USER $USER
WORKDIR /home/$USER

# Install OH-MY-ZSH
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# This is ugly, but it prevents the need from running the Docker image with `--entrypoint=/usr/bin/zsh`
RUN echo "exec zsh" >> .bashrc

# Install SDKMAN! and get the JVM etc. (simply get the latest versions)
RUN curl -s "https://get.sdkman.io?rcupdate=false" | bash
RUN echo "source /home/$USER/.sdkman/bin/sdkman-init.sh" >> /home/$USER/.zshrc
RUN zsh -c "source /home/$USER/.sdkman/bin/sdkman-init.sh && sdk install java"
RUN zsh -c "source /home/$USER/.sdkman/bin/sdkman-init.sh && sdk install kotlin"
RUN zsh -c "source /home/$USER/.sdkman/bin/sdkman-init.sh && sdk install gradle"
RUN zsh -c "source /home/$USER/.sdkman/bin/sdkman-init.sh && sdk install maven"

WORKDIR /home/$USER/project
