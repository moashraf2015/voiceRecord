# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
# 	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
# ENV LANG en_US.utf8

# WORKDIR /usr/src/app

# COPY . .
# RUN pip install -r requirements.txt



# CMD [ "python", "./predictions.py" ]

FROM python:3

WORKDIR /usr/src/app

COPY ./app/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install keras

COPY . .
CMD [ "python", "./predictions.py" ]
