docker run --rm -it --name quicklisp-base \
       -v $HOME/build/upstream-cache:/home/quicklisp/quicklisp-controller/upstream-cache \
       -v $HOME/build/dist:/home/quicklisp/quicklisp-controller/dist \
       -v $HOME/build/quicklisp-projects:/home/quicklisp/quicklisp-projects \
       quicklisp/quicklisp-base
