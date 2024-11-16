FROM ubuntu

RUN apt-get update && apt-get install -y xterm
RUN useradd -ms /bin/bash xterm
USER xterm
WORKDIR /home/xterm

# docker run -it --rm -e DISPLAY=${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix local/xterm xterm