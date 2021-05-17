FROM python:3

ENV PYTHONUNBUFFERED 1

WORKDIR /djangowebsite

ADD . /djangowebsite

COPY ./requirements.txt /djangowebsite/requirements.txt

RUN pip install -r requirements.txt