FROM python:3.9.10
RUN apt update -y && apt upgrade -y
RUN apt install gunicorn python3-flask -y
WORKDIR /usr/src/app
COPY . .
# RUN pip3 install -r /requirements.txt
ENV FLASK_APP main.py
CMD [ "gunicorn", "-w", "4", "-b", ":80", "main:app" ]
# ENTRYPOINT ["tail", "-f", "/dev/null"]