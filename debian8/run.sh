IMAGE=${1:-quicklisp/quicklisp-base:debian8}
NAME=qlb

docker run --rm -it --name $NAME \
       -e GIT_PAGER='' \
       -e GIT_AUTHOR_NAME='Zach Beane' \
       -e GIT_AUTHOR_EMAIL='zach@quicklisp.org' \
       -e GIT_COMMITTER_NAME='Zach Beane' \
       -e GIT_COMMITTER_EMAIL='zach@quicklisp.org' \
       -v $HOME/build/upstream-cache:/home/quicklisp/quicklisp-controller/upstream-cache \
       -v $HOME/build/dist:/home/quicklisp/quicklisp-controller/dist \
       -v $HOME/build/quicklisp-projects:/home/quicklisp/quicklisp-projects \
       $IMAGE
