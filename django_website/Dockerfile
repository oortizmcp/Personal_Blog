FROM python:3
ENV PYTHONUNBUFFERED 1

RUN mkdir /django_website

WORKDIR /django_website

ADD . /django_website

COPY ./requirements.txt /django_website/requirements.txt

RUN pip install -r requirements.txt
COPY . /django_website

EXPOSE 8083

CMD ["python", "manage.py", "runserver", "0.0.0.0:8083"]