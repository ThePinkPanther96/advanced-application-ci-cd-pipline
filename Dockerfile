FROM python:3

MAINTAINER Gal

WORKDIR /app

COPY app /app

COPY app/requirements.txt ./

RUN pip install --upgrade pip

RUN echo ${BUILD_NUMBER} && pip install --no-cache-dir -r requirements.txt

EXPOSE 5001

ARG BUILD_NUMBER
ARG API_KEY
ARG BASE_URL

ENV ENVIRONMENT=DEV
ENV API_KEY=${API_KEY}
ENV BASE_URL=${BASE_URL}

ENTRYPOINT ["python", "weather.py"]