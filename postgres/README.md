# Postgres Notes


### Install stable repository
```
helm repo add helmstable https://kubernetes-charts.storage.googleapis.com/
```
### Install Postgres
```
helm install -n postgres --set service.type=NodePort helmstable/postgresql
```