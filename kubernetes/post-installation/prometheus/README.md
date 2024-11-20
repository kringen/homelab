# Add Prometheus helm repo
```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

# Install prometheus
```
kubectl create namespace prometheus
helm install prometheus -n prometheus bitnami/kube-prometheus
```

# Installation Output
```
LAST DEPLOYED: Wed Mar 16 22:53:17 2022
NAMESPACE: prometheus
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kube-prometheus
CHART VERSION: 6.6.13
APP VERSION: 0.55.0

** Please be patient while the chart is being deployed **

Watch the Prometheus Operator Deployment status using the command:

    kubectl get deploy -w --namespace prometheus -l app.kubernetes.io/name=kube-prometheus-operator,app.kubernetes.io/instance=prometheus

Watch the Prometheus StatefulSet status using the command:

    kubectl get sts -w --namespace prometheus -l app.kubernetes.io/name=kube-prometheus-prometheus,app.kubernetes.io/instance=prometheus

Prometheus can be accessed via port "9090" on the following DNS name from within your cluster:

    prometheus-kube-prometheus-prometheus.prometheus.svc.cluster.local

To access Prometheus from outside the cluster execute the following commands:

    echo "Prometheus URL: http://127.0.0.1:9090/"
    kubectl port-forward --namespace prometheus svc/prometheus-kube-prometheus-prometheus 9090:9090

Watch the Alertmanager StatefulSet status using the command:

    kubectl get sts -w --namespace prometheus -l app.kubernetes.io/name=kube-prometheus-alertmanager,app.kubernetes.io/instance=prometheus

Alertmanager can be accessed via port "9093" on the following DNS name from within your cluster:

    prometheus-kube-prometheus-alertmanager.prometheus.svc.cluster.local

To access Alertmanager from outside the cluster execute the following commands:

    echo "Alertmanager URL: http://127.0.0.1:9093/"
    kubectl port-forward --namespace prometheus svc/prometheus-kube-prometheus-alertmanager 9093:9093

```

# Check installation
```
kubectl port-forward --namespace default svc/prometheus-kube-prometheus-prometheus 9090:9090
```

# Install Grafana
```
helm install grafana bitnami/grafana
```

# Check Installation
```
1. Get the application URL by running these commands:
    echo "Browse to http://127.0.0.1:8080"
    kubectl port-forward svc/grafana 8080:3000 &

2. Get the admin credentials:

    echo "User: admin"
    echo "Password: $(kubectl get secret grafana-admin --namespace default -o jsonpath="{.data.GF_SECURITY_ADMIN_PASSWORD}" | base64 --decode)"

```