FROM debian:latest

RUN apt-get update
RUN apt-get -y install wget

# Install the not-in-debian prerequisites, built with checkinstall
RUN mkdir /build
WORKDIR /build
RUN wget https://www.quicklisp.org/quicklisp-controller/packages.tar
RUN tar xvf packages.tar
RUN dpkg -i packages/*.deb

# Install the big list of known prerequisites
COPY debian-9-packages.txt /build
RUN apt-get -y install $(cat debian-9-packages.txt)


# Other one-off requirements
RUN apt-get -y install git build-essential sudo sbcl emacs-nox

# Create quicklisp user
RUN adduser --shell /bin/bash --uid 1000 --system quicklisp
RUN echo "quicklisp ALL = NOPASSWD: ALL" > /etc/sudoers.d/quicklisp

# Install quicklisp and quicklisp-controller prerequisites
RUN wget https://beta.quicklisp.org/quicklisp.lisp
RUN su quicklisp -c 'sbcl --noinform --no-userinit --no-sysinit --non-interactive --load /build/quicklisp.lisp --eval "(quicklisp-quickstart:install)"'
WORKDIR /home/quicklisp/quicklisp/local-projects
RUN git clone https://github.com/quicklisp/project-info.git
RUN git clone https://github.com/xach/commando.git
RUN git clone https://github.com/xach/githappy.git
RUN git clone https://github.com/quicklisp/quicklisp-controller.git

# This inhibits prompting for password on missing/private repo URLs
RUN su quicklisp -c 'git config --global core.askpass echo'

# Don't leave it around
RUN rm -rf /build
WORKDIR /

# Other setup
ENV LANG=C.UTF-8

RUN mkdir /home/quicklisp/quicklisp-controller
RUN chown -R quicklisp /home/quicklisp/quicklisp-controller /home/quicklisp/quicklisp
RUN su quicklisp -c 'sbcl --noinform --no-userinit --no-sysinit --non-interactive --load $HOME/quicklisp/setup.lisp --eval "(ql-util:without-prompting (ql:add-to-init-file))"'
RUN su quicklisp -c 'ln -s ~/quicklisp-projects ~/quicklisp-controller/projects'

# Warm the fasl cache of quicklisp-controller
RUN su quicklisp -c 'sbcl --no-userinit --no-sysinit --non-interactive --load $HOME/quicklisp/setup.lisp --eval "(ql:quickload :quicklisp-controller)"'

# Required binaries
WORKDIR /home/quicklisp
RUN su quicklisp -c 'mkdir /home/quicklisp/bin'
RUN su quicklisp -c 'sbcl --non-interactive --eval "(ql:quickload :buildapp)" --eval "(buildapp:build-buildapp \"~/bin/buildapp\")"'
RUN su quicklisp -c 'sbcl --non-interactive --eval "(ql:quickload :quicklisp-controller)" --eval "(quicklisp-controller::rebuild-tools)"'

# Start as quicklisp, not root
CMD su -l quicklisp
