FROM balenalib/raspberrypi4-64-debian-python:latest
ENTRYPOINT ["/bin/bash"]
CMD [ "/bin/bash", ]
WORKDIR /usr/src/app

COPY . .
RUN sudo apt update
RUN sudo apt upgrade
RUN sudo pip3 install --no-cache-dir -r requirements.txt
RUN python3 prediction.py

COPY . .

