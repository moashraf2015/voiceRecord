# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
# 	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
# ENV LANG en_US.utf8

# WORKDIR /usr/src/app

# COPY . .
# RUN pip install -r requirements.txt



# CMD [ "python", "./predictions.py" ]

#FROM python:3.7-alpine3.12




# WORKDIR /usr/src/app

# COPY ./app/requirements.txt ./
# RUN ls -l /usr/local/bin/python3
# RUN chmod +x /usr/local/bin/python3
# RUN apk update && apk add portaudio-dev
# RUN /usr/local/bin/python -m pip install --upgrade pip
# RUN /usr/local/bin/python -m pip install --upgrade wheel
# RUN pip install numba
# RUN  pip install scipy
# RUN pip install keras
# #RUN pip install tensorflow
# RUN  pip install joblib

# RUN pip install PyAudio
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . .
# CMD [ "python3", "./predictions.py" ]


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
RUN pip install sounddevice
RUN pip install --no-cache-dir -r requirements.txt


COPY . .

ENV PORT 80
RUN chmod 777 ./app/prediction.py
ENTRYPOINT ["./app/prediction.py"]
CMD [ "/bin/bash","python3", "./prediction.py", "-m" , "flask", "run", "--host=0.0.0.0"]

