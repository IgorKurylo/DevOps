FROM python:3.9

ENV PYTHONUNBUFFERED=1

WORKDIR /consumer

COPY requirments.txt requirments.txt

RUN pip install -r requirments.txt

COPY . .

CMD ["python","main.py"]