# Базовый образ с Python
FROM python:3.12-slim

LABEL maintainer="Margulan Beket (38109)"

# Рабочая папка внутри контейнера
WORKDIR /app

# Копируем приложение, конфиг и информацию о студенте
COPY app/ /app/
COPY config/app.conf /app/config/app.conf
COPY Beket_Margulan_info.txt /app/

# Создаём непривилегированного пользователя (не запускаем от root)
RUN useradd --create-home appuser && chown -R appuser:appuser /app

# Значения по умолчанию — можно переопределить через docker run -e
ENV STUDENT_NAME=Margulan \
    STUDENT_SURNAME=Beket \
    STUDENT_GROUP=it2-2302 \
    STUDENT_ID=38109 \
    APP_PORT=5050 \
    PYTHONUNBUFFERED=1

EXPOSE 5050

USER appuser

CMD ["python", "app.py"]
