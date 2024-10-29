#!/bin/bash

cleanup() {
    echo "Завершение процессов"
    #Проверяет если значение не пустое и удалось убить процесс
    if [ -n "$BLACKBOX_PID" ]; then
      echo "Blackbox Exporter завершён"
    fi

    if [ -n "$PROMETHEUS_PID" ]; then
      echo "Prometheus завершён"
    fi

    exit 0
}

trap cleanup SIGINT SIGTERM

sudo ./blackbox_exporter --config.file=blackbox.yml 2>&1 | grep "level=error" &
BLACKBOX_PID=$!
sleep 1

if ps -p $BLACKBOX_PID > /dev/null; then
    echo "Blackbox Exporter запущен с PID $BLACKBOX_PID"
else
    echo "Не удалось запустить Blackbox Exporter"
    BLACKBOX_PID=""  # Очистка переменной PID
fi


sleep 2

sudo ./prometheus --config.file=prometheus.yml 2>&1 | grep "level=error" &
PROMETHEUS_PID=$!
sleep 1

if ps -p $PROMETHEUS_PID > /dev/null; then
    echo "Prometheus запущен с PID $PROMETHEUS_PID"
else
    echo "Не удалось запустить Prometheus"
    PROMETHEUS_PID=""  # Очистка переменной PID
fi

echo "Для выхода из программы нажмите CTRL + C"

if [ -n "$BLACKBOX_PID" ]; then
    wait "$BLACKBOX_PID"
fi

if [ -n "$PROMETHEUS_PID" ]; then
    wait "$PROMETHEUS_PID"
fi
