# Lab 26: Updating Applications and Rolling Back Changes with Kubernetes

- ﻿﻿Deploy NGINX with 3 replicas.
﻿﻿- Create a service to expose NGINX deployment.
﻿﻿- Use port forwarding to access NGINX service locally.
﻿﻿- Update NGINX image to Apache.
﻿﻿- View deployment's rollout history.
﻿﻿- Roll back NGINX deployment to the previous image version and Monitor pod status.
  
---
## Step 1: Deploy NGINX with 3 Replicas

### Create the NGINX Deployment YAML

Create a file named `nginx-deployment.yaml` for the NGINX deployment and apply.

```
kubectl apply -f nginx-deployment.yaml
kubectl get deployments
kubectl get pods

```
![image](https://github.com/user-attachments/assets/db4ae34a-2f78-4afc-b563-6ea2c41c5abe)

## Step 2: Create a Service to Expose the NGINX Deployment

Create the NGINX Service YAML
Create a file named nginx-service.yaml to define the service that exposes the NGINX deployment and apply.

```
kubectl apply -f nginx-service.yaml
kubectl get svc
```

![image](https://github.com/user-attachments/assets/2a72eb79-18b7-40bf-907c-a8b09ec1eebd)

![image](https://github.com/user-attachments/assets/5891c20b-cc6d-4f4e-8a4d-6fd6f627d6dc)

## Step 3: Use Port Forwarding to Access NGINX Service Locally
Set Up Port Forwarding
Use kubectl to forward the NGINX service to your local machine:

```
kubectl port-forward svc/nginx-service 8080:80
```

## Step 4: Update NGINX image to Apache
Edit the NGINX deployment to use the Apache image:

```
kubectl set image deployment/nginx-deployment nginx=httpd:latest
```

![image](https://github.com/user-attachments/assets/a6bc86f0-461d-4433-b12f-b468d8c55f5b)

![image](https://github.com/user-attachments/assets/a43bed06-3fe1-41ef-810e-bc3a5fb423a8)

- view the rollout history of the deployment, use the following command:

```
kubectl rollout history deployment/nginx-deployment
```

![image](https://github.com/user-attachments/assets/bb05c836-e7cc-4207-87e4-56e8d7c7e7fa)

-Apache Output:

![image](https://github.com/user-attachments/assets/11afac29-08a0-495e-a0eb-d25d146caa7d)

Step 6: Roll back NGINX deployment to the previous image version
To roll back to the previous version of the deployment (NGINX), use:

![image](https://github.com/user-attachments/assets/81028775-e931-413c-9df5-d15475a97ff6)

```
kubectl describe pod nginx-deployment-96b9d695-szkdp
```
![image](https://github.com/user-attachments/assets/b2a9a241-0abd-46ed-b1a5-2e7a85370c13)




