FROM  balenalib/raspberrypi4-64-ubuntu-python:latest

WORKDIR /usr/src/app

COPY . .
RUN pip3 install -r requirements.txt



CMD [ "python", "./predictions.py" ]