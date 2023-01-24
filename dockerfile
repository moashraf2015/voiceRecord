FROM balenalib/raspberrypi4-64-debian-python:latest

WORKDIR /usr/src/app

COPY . .
RUN pip install --no-cache-dir -r requirements.txt



CMD [ "python", "./predictions.py" ]