# AlertManager

A test playground 

Start, create a test alert, and check the result:

```bash
docker compose up -d
./create_test_alert.sh
./silence_test_alert.sh
./unsilence_all_alerts.sh
docker compose logs 
docker compose down
```

Reach UI at http://localhost:9093

AlertManager API v2 spec available at https://github.com/prometheus/alertmanager/blob/main/api/v2/openapi.yaml