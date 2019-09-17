# deploy opencart
kubectl create namespace opencart
helm install --name opencart --namespace opencart --set opencartHost=localhost,service.type=LoadBalancer helmstable/opencart 
export APP_PORT=$(kubectl get svc --namespace opencart opencart -o jsonpath="{.spec.ports[0].nodePort}")
export APP_HOST=$(kubectl get nodes --namespace opencart -o jsonpath="{.items[0].status.addresses[0].address}")
export APP_DATABASE_PASSWORD=$(kubectl get secret --namespace opencart opencart-mariadb -o jsonpath="{.data.mariadb-password}" | base64 --decode)
helm upgrade opencart -i helmstable/opencart --namespace=opencart --set opencartHost=localhost,opencartPassword=$APP_PASSWORD,mariadb.db.password=$APP_DATABASE_PASSWORD,service.type=LoadBalancer
echo Admin Password: $(kubectl get secret --namespace opencart opencart -o jsonpath="{.data.opencart-password}" | base64 --decode)


https://stackoverflow.com/questions/28903963/how-to-reset-opencart-2-administrative-password
resetting password
d1c194daffb03fc2653027c87f76a12a4eaeac5f
x3x6r693j