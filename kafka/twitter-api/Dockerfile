FROM python:3.9

WORKDIR /producer

COPY requirments.txt requirments.txt

RUN pip install -r requirments.txt

COPY /src .

EXPOSE 8080

CMD ["python","main.py"]