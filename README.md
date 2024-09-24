# AlertManager

## Local test playground 

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

## Mimir AlertManager

Troubleshooting the specific case of Mimir AlertManager, starting a pod "like a real one" but sleep infinity / root

```bash
kubectl -n monitoring apply -f test-pod-manifest.yaml

# First terminal
kubectl -n monitoring exec -ti mimir-alertmanager-test -- ash
apk add vim curl jq bat # ignore errors
cp /etc/mimir/mimir.yaml /tmp/mimir.yaml
cp /configs/alertmanager_fallback_config.yaml /tmp/config.yaml
cp /templates/alertmanager_templates.tmpl /tmp/templates.yaml
# Edit the above files so mimir.yaml => config.yaml => templates.yaml
/bin/mimir -target=alertmanager -config.expand-env=true -config.file=/tmp/mimir.yaml -log.level debug 2>&1 | grep -v -E "Parsing|MultiTenantAlertmanager|Initiating pu|memberlist|cluster|unexpected|module waiting|object stor|tracker|Invalidating|configured Transport|uspect|Stream|irectories"
# Ctrl-C, tweak files, start again

# Second terminal
kubectl -n monitoring exec -ti mimir-alertmanager-test -- ash

# List alerts
curl -u mimir:______________________ -H "Content-Type: application/json" -H "X-Scope-OrgID: 1" http://localhost:8080/alertmanager/api/v2/alerts | jq 

# Create alert
# Beforehand, write down test_alert.json
curl -X POST -u mimir:______________________ -H "Content-Type: application/json" -H "X-Scope-OrgID: 1" http://localhost:8080/alertmanager/api/v2/alerts -d @test_alert.json

# Display AlertManager config
 curl -s -u mimir:______________________ -H "Content-Type: application/json" -H "X-Scope-OrgID: 1" http://localhost:8080/alertmanager/api/v2/status | jq -r '.config.original' | bat --theme gruvbox-light -l yaml
# Might need to rm -rf /data/*

```