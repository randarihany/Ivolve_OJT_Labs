# Lab 28: Storage Configuration
* Create Nginx deployment with 1 replica.
* Exec into the pod and create a file at /usr/share/nginx/html/hello.txt with the content "hello iVolve"
* verify the file is served by using curl localhost/hello.txt.
* Delete the NGINX pod and wait for the deployment to create a new pod
* exec into the new pod and verify the file at /usr/share/nginx/html/hello.txt is no longer present.
* Create a Persistent Volume Claim (PVC).
* Modify the deployment to attach the PVC to the pod at /usr/share/nginx/html.
* Repeat the previous steps and Verify the file persists across pod deletions.
* Make a comparison between PV, PVC, and StorageClass.

---

### Step 1: Create an Nginx Deployment with 1 Replica

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

Create a deployment YAML file (nginx-deployment.yaml):
```
kubectl apply -f nginx-deployment.yaml 
kubectl get pods
```
![image](https://github.com/user-attachments/assets/044aeb42-b1dc-4a45-898d-a9cc5b050318)

```
kubectl port-forward svc/nginx-service 8080:80
```

![image](https://github.com/user-attachments/assets/d2cf858d-f2fc-4042-aee6-031f39337099)


![image](https://github.com/user-attachments/assets/559ae7a6-c18f-421c-a8b8-4d20f69133d5)



![image](https://github.com/user-attachments/assets/fe9517b1-46ea-4adc-99d5-92d315077767)


![image](https://github.com/user-attachments/assets/30250103-7c6f-4bcf-959c-75ccaabfa95d)




