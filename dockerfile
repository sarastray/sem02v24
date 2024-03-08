FROM ubuntu:24.04

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get install -y \
    sudo \
    nano \
    wget \
    curl \
    git

RUN useradd -G sudo -m -d /home/sarastray -s /bin/bash -p "$(openssl passwd -1 sara2002)" sarastray

USER sarastray
WORKDIR /home/sarastray

RUN mkdir hacking \
    && cd hacking \
    && curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
    && chmod 764 pawned.sh \
    && cd ..

RUN git config --global user.email "sara.stray@online.no" \
    && git config --global user.name "sarastray" \
    && git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
    && mkdir -p github.com/sarastray/sem02v24

USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-386.tar.gz \
    | tar xvz -C /usr/local

USER sarastray
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/sarastray/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"