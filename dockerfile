FROM  balenalib/raspberrypi4-64-ubuntu-python:latest

WORKDIR /usr/src/app

COPY . .
RUN pip install -r requirements.txt



CMD [ "python", "./predictions.py" ]