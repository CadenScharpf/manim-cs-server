# docker run --rm -it -p 5000:5000 --name mcs-server manim-cs-server

FROM python:3.8-slim

RUN apt-get update -qq \
    && apt-get install --no-install-recommends -y \
        ffmpeg \
        build-essential \
        gcc \
        cmake \
        libcairo2-dev \
        libffi-dev \
        libpango1.0-dev \
        freeglut3-dev \
        pkg-config \
        make \
        wget \
        ghostscript

# setup a minimal texlive installation
COPY texlive-profile.txt /tmp/
ENV PATH=/usr/local/texlive/bin/armhf-linux:/usr/local/texlive/bin/aarch64-linux:/usr/local/texlive/bin/x86_64-linux:$PATH
RUN wget -O /tmp/install-tl-unx.tar.gz http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir /tmp/install-tl && \
    tar -xzf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1 && \
    /tmp/install-tl/install-tl --profile=/tmp/texlive-profile.txt \
    && tlmgr install \
        amsmath babel-english cbfonts-fd cm-super ctex doublestroke dvisvgm everysel \
        fontspec frcursive fundus-calligra gnu-freefont jknapltx latex-bin \
        mathastext microtype ms physics preview ragged2e relsize rsfs \
        setspace standalone tipa wasy wasysym xcolor xetex xkeyval

# install manim
RUN pip install manim
# install manimcs
RUN pip install matplotlib
RUN pip install manimcs
RUN pip install flask




ARG NB_USER=manimuser
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /manim

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# create working directory for user to mount local directory into
WORKDIR ${HOME}
USER root
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}
RUN chmod 777 ${HOME}

# Copy app
COPY app /app
RUN mkdir /app/output /app/output/text /app/output/video /app/output/tex
RUN chown -R ${NB_USER}:${NB_USER} /app
RUN chmod -R 777 /app

USER ${NB_USER}



#CMD [ "/bin/bash" ]
WORKDIR /app
CMD [ "flask", "run", "--host=0.0.0.0" ]