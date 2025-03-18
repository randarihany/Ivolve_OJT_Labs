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

-Apply a deployment YAML file:

```
kubectl apply -f nginx-deployment.yaml 
kubectl get pods
```
![image](https://github.com/user-attachments/assets/044aeb42-b1dc-4a45-898d-a9cc5b050318)

### Step 2: Create an Nginx Service

```
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx  # Match the pods with the "app: nginx" label
  ports:
    - protocol: TCP
      port: 80        
      targetPort: 80  
  type: ClusterIP 
```

```
kubectl apply -f nginx-service.yaml 
kubectl get svc
```

- Port-forward the pod to your local machine:
  
```
kubectl port-forward svc/nginx-service 8080:80
```

### Step 3: Exec into the Pod and Create a File

1- Get the pod name
2- Exec into the pod
3- Inside the pod, create the file

```
kubectl get pods
kubectl exec -it nginx-deployment- -- /bin/bash
echo "hello iVolve" > /usr/share/nginx/html/hello.txt
```

### Step 4:  Verify the File is Served

![image](https://github.com/user-attachments/assets/d2cf858d-f2fc-4042-aee6-031f39337099)

### Step 5: Delete the NGINX Pod and Wait for a New One

- Exec into the New Pod and Verify the File is Gone

![image](https://github.com/user-attachments/assets/559ae7a6-c18f-421c-a8b8-4d20f69133d5)

### Step 6: Create a Persistent Volume Claim (PVC)

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nginx-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```
- Apply pvc

```
kubectl apply -f nginx-pvc.yaml
```

### Step 7: Modify the Deployment to Attach the PVC

```
        volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: nginx-storage
      volumes:
      - name: nginx-storage
        persistentVolumeClaim:
          claimName: nginx-pvc
```

```
kubectl apply -f nginx-deployment.yaml
```
### Step 8: Repeat the Previous Steps and Verify File Persistence

![image](https://github.com/user-attachments/assets/fe9517b1-46ea-4adc-99d5-92d315077767)


![image](https://github.com/user-attachments/assets/30250103-7c6f-4bcf-959c-75ccaabfa95d)




