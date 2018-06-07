FROM debian:latest

RUN adduser --system quicklisp
RUN chsh --shell /bin/bash quicklisp
RUN apt-get update
RUN apt-get -y install wget git build-essential sudo sbcl
RUN echo "quicklisp ALL = NOPASSWD: ALL" > /etc/sudoers.d/quicklisp

ENV LANG=C.UTF-8

RUN mkdir /build
WORKDIR /build
RUN wget https://www.quicklisp.org/quicklisp-controller/packages.tar
RUN tar xvf packages.tar
RUN dpkg -i packages/*.deb

RUN wget https://beta.quicklisp.org/quicklisp.lisp
RUN su quicklisp -c 'sbcl --noinform --no-userinit --no-sysinit --non-interactive --load /build/quicklisp.lisp --eval "(quicklisp-quickstart:install)"'
WORKDIR /home/quicklisp/quicklisp/local-projects
RUN git clone https://github.com/quicklisp/project-info.git
RUN git clone https://github.com/xach/commando.git
RUN git clone https://github.com/xach/githappy.git
RUN git clone https://github.com/quicklisp/quicklisp-controller.git

WORKDIR /home/quicklisp/quicklisp/local-projects/quicklisp-controller/debian-setup
RUN test -f debian-9-packages.txt
RUN apt-get -y install $(cat debian-9-packages.txt)

RUN rm -rf /build

CMD su -l quicklisp
