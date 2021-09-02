# syntax=docker/dockerfile:1

FROM python:slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD [ "gunicorn", "-w" , "4" , "-b", "0.0.0.0:80", "app:app"]
