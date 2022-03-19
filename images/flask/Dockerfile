FROM python:3.9.10
RUN apt update -y && apt upgrade -y && \
    apt install gunicorn python3-flask python3-requests -y
RUN pip3 install requests
WORKDIR /usr/src/app
COPY . .
ENV FLASK_APP main.py
CMD [ "gunicorn", "-w", "4", "-b", ":80", "main:app" ]