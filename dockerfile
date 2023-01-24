FROM balenalib/raspberrypi4-64-debian-python:latest

WORKDIR /usr/src/app

COPY . .
RUN /bin/bash -c pip install --no-cache-dir -r requirements.txt
RUN python3 prediction.py

COPY . .

CMD [ "/bin/bash","python", "./prediction.py" ]