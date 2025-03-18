### Lab 26: Updating Applications and Rolling Back Changes with Kubernetes:

- Deploy NGINX with 3 replicas
- Create a service to expose NGINX deployment
- Use port forwarding to access NGINX service locally
- Update NGINX image to Apache
- View deployment's rollout history
- Roll back NGINX deployment to the previous image version and Monitor pod status

---
## Step 1: Deploy NGINX with 3 Replicas
- Create the NGINX Deployment YAML
- Create a file named nginx-deployment.yaml for the NGINX deployment and apply.

```
kubectl apply -f nginx-deployment.yaml
kubectl get deployments
kubectl get pods
```

![image](https://github.com/user-attachments/assets/c1828a90-faf4-4f46-88b6-4aca6c2722b6)

## Step 2: Create a Service to Expose the NGINX Deployment
- the NGINX Service YAML Create a file named nginx-service.yaml to define the service that exposes the NGINX deployment and apply.

```
kubectl apply -f nginx-service.yaml
kubectl get svc
```
![image](https://github.com/user-attachments/assets/3da444aa-950c-4a89-8712-cac4dd7baa8c)


## Step 3: Use Port Forwarding to Access NGINX Service Locally
- Set Up Port Forwarding Use kubectl to forward the NGINX service to your local machine:

```
kubectl port-forward svc/nginx-service 8080:80
```
![image](https://github.com/user-attachments/assets/87c23493-fa97-426b-b938-90383a3bab37)

## Step 4: Update NGINX image to Apache
- Edit the NGINX deployment to use the Apache image:
  
```
kubectl set image deployment/nginx-deployment nginx=httpd:latest
```

![image](https://github.com/user-attachments/assets/401c4a8c-9b3e-4c47-a27a-56f7e364d038)

## Step 5: View Deployment's Rollout History
- view the rollout history of the deployment, use the following command:
```
kubectl rollout history deployment/nginx-deployment
```
![image](https://github.com/user-attachments/assets/d7bc485c-f702-43dc-b943-ae98db87a097)
![image](https://github.com/user-attachments/assets/793d18ae-09bb-427b-9c26-dae305991c01)

- Apache Output:
  
![image](https://github.com/user-attachments/assets/6ff30bfd-b4fb-4388-8d5a-2f673a1cfe42)


## Step 6: Roll back NGINX deployment to the previous image version
- To roll back to the previous version of the deployment (NGINX), use:

![image](https://github.com/user-attachments/assets/016807ee-1c46-4d66-ae20-c157a714c7df)


### Step 7:Describe a Pod for Detailed Information
```
kubectl describe pod nginx-deployment-96b9d695-szkdp
```

![image](https://github.com/user-attachments/assets/256dfb2b-20d6-48ad-b7f7-79c1068d5371)


