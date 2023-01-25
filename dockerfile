# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
# 	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
# ENV LANG en_US.utf8

# WORKDIR /usr/src/app

# COPY . .
# RUN pip install -r requirements.txt



# CMD [ "python", "./predictions.py" ]

FROM python:3.7.0



WORKDIR /usr/src/app

COPY ./app/requirements.txt ./
RUN apt-get update && apt-get install -y portaudio19-dev
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN /usr/local/bin/python -m pip install --upgrade wheel
RUN  pip install scipy
RUN pip install keras
#RUN pip install tensorflow
RUN  pip install joblib
RUN pip install numba
RUN pip install PyAudio
RUN pip install --no-cache-dir -r requirements.txt


COPY . .
CMD [ "python3", "./predictions.py" ]
