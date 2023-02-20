FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . ./

ENV FLASK_APP=app.py
ENV FLASK_ENV=production

EXPOSE 5000

RUN useradd --create-home app
USER app

CMD ["python", "run.py"]
