FROM python:3.10
RUN useradd user
WORKDIR /app/
COPY ./code/ /app/
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
USER user
CMD ["python", "/app/app.py"]