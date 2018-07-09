IMAGE=${1:-quicklisp/quicklisp-base:debian8}
NAME=qlb

docker run --rm -it --name $NAME \
       -v $HOME/build/upstream-cache:/home/quicklisp/quicklisp-controller/upstream-cache \
       -v $HOME/build/dist:/home/quicklisp/quicklisp-controller/dist \
       -v $HOME/build/quicklisp-projects:/home/quicklisp/quicklisp-projects \
       $IMAGE
