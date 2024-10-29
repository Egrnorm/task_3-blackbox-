
### Запуск  
1. ##### Клонируем репозиторий:  
- `git clone https://github.com/Egrnorm/task_blackbox-exporter.git`  
2. ##### Скачиваем Git LFS для корректного запуска бинарных файлов  
- Для Debian:  
  - `sudo apt install git-lfs`  
- Для Fedora:  
  - `sudo dnf install git-lfs`  
3. ##### Переходим в папку:  
- `cd task_blackbox-exporter`  
4. ##### Активация загрузки больших файлов:  
- `git lfs pull`  
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

---
### Немного о проекте  
Этот проект представляет собой систему мониторинга сайта (**ptsecurity.com**) с помощью Prometheus и Blackbox Exporter для отслеживания доступности и производительности. Конфигурация включает несколько проверок, каждая из которых настроена как отдельная задача (job) в Prometheus  
#### А именно:  
1. **https_check**:  
- Проверяет доступность HTTPS на ptsecurity.com  
2. **tcp_connect_check**:  
- Проверяет доступность TCP-портов 80 и 443 на ptsecurity.com  
3. **icmp_check**:  
- Выполняет проверку доступности сайта ptsecurity.com через ICMP (ping)  
4. **domain_in_dns_check**:  
- Проверяет, что домен ptsecurity.com правильно разрешается через DNS-сервер  
- Выполняет запрос на общедоступный DNS-сервер 8.8.8.8, чтобы убедиться, что домен присутствует в DNS-записях  
- В случае реального использования рекомендуется указать собственные DNS-серверы вместо общедоступных  
5. **is_ip_change_check**:  
- Выполняет проверку изменился ли IP-адрес для ptsecurity.com через DNS  
- Служит для контроля изменений IP-адреса домена: если IP-адрес санкционированно изменился, конфигурацию Blackbox Exporter нужно обновить, чтобы он продолжал правильно отслеживать целевой IP  
- Запросы идут на DNS-сервер 8.8.8.8, однако в реальной среде рекомендуется использовать собственные DNS-серверы  
6. **security_headers_check**:  
- Проверяет наличие заголовков безопасности на сайте ptsecurity.com  
- Контролирует наличие таких заголовков, как X-XSS-Protection, X-Content-Type-Options и Strict-Transport-Security
