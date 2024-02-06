# Resize my EC2 EBS volume instance fot ext 4 file type

Increase the EBS volume on the AWS console then run the commands

1. Check
```df -hT```
2. Check the block size
```sudo lsblk```
3. ```df -hT```
4. ```sudo growpart /dev/nvme0n1 1```
5. ```sudo lsblk```
6. ```df -hT```
7. ```sudo resize2fs /dev/nvme0n1p1```
8. ```df -hT```


Kubernetes using minikube
===

1. Install minikube on Linux amd64
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```
2. Setup an alias
```
alais k="minikube kubectl --"
```

3. Start minikube using containerd runtime 
minikube start --driver=docker --container-runtime=containerd --network-plugin=cni --cni=calico

4. Deployment
```
k create deployment crm-app --image yalecthub/suitecrm:latest --dry-run=client -o yaml > deploy.yml

k apply -f deploy.yml

k get pods
```
5. Services
```
k expose deployment crm-app --name crm-svc --target-port 80 --port 3000 --type NodePort --dry-run=client -oyaml > svc.yml

k apply -f deploy.yml

k get svc

k get nodes -owide
```
6. Check if you can connect to the node
```
telnet 192.168.49.2 31064
```
where INTERNAL_IP = 192.168.49.2
      NODE_PORT = 31064

7. Check localhost to see suitecrm running:
```
http://192.168.49.2:31064
```

8. You can also do port forwarding
```
k port-forward svc/crm-svc 8080:80 --address='0.0.0.0'
```
Access it using:
```
http://<instance_ip>:8080
```

9. Stop all deployment and services

```
minikube delete --all
```