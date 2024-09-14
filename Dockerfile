FROM python:3

MAINTAINER Gal

WORKDIR /app

ARG BUILD_NUMBER

ENV ENVIRONMENT=DEV

COPY app/requirements.txt ./

RUN echo ${BUILD_NUMBER} && pip install --no-cache-dir -r requirements.txt

COPY app /app

EXPOSE 5001

ENTRYPOINT ["python", "weather.py"]