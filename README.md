
### Для запуска  
1. ##### Клонируем репозиторий:  
- `git clone https://github.com/Egrnorm/task_blackbox-exporter.git`  
2. ##### Переходим в папку:  
- `cd task_blackbox-exporter`  
3. ##### Запускаем скрипт, который автоматизирует процесс запуска BlackBox exporter и Prometheus:
- `sudo ./start.sh`  
4. #### Теперь Prometheus доступен по адресу
- `localhost:9090`
---
### Запуска без использования скрипта
1. ##### Клонируем репозиторий:  
- `git clone https://github.com/Egrnorm/task_blackbox-exporter.git`  
2. ##### Переходим в папку:  
- `cd task_blackbox-exporter`
3. ##### Сначала запускаем BlackBox exporter
- `sudo ./blackbox_exporter --config.file=blackbox.yml`
4. ##### Потом запускаем Prometheus
- `sudo ./prometheus --config.file=prometheus.yml`
