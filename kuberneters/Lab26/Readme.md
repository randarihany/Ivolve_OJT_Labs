# Lab 26: Updating Applications and Rolling Back Changes with Kubernetes

This guide will walk you through the steps to complete Lab 26, which focuses on updating applications, rolling back changes, and monitoring pod statuses in a Kubernetes cluster.

## Prerequisites

Ensure you have the following before starting:

- A working Kubernetes cluster (local, such as Minikube, or cloud-based like GKE, EKS, or AKS).
- `kubectl` installed and configured to interact with your Kubernetes cluster.

---

## Step 1: Deploy NGINX with 3 Replicas

### Create the NGINX Deployment YAML

Create a file named `nginx-deployment.yaml` for the NGINX deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
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
Apply the YAML File
Run the following command to apply the deployment:

bash
Copy
kubectl apply -f nginx-deployment.yaml
Verify the Deployment
Check that the deployment and pods were successfully created:

bash
Copy
kubectl get deployments
kubectl get pods
Step 2: Create a Service to Expose the NGINX Deployment
Create the NGINX Service YAML
Create a file named nginx-service.yaml to define the service that exposes the NGINX deployment:

yaml
Copy
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
Apply the YAML File
Run the following command to apply the service:

bash
Copy
kubectl apply -f nginx-service.yaml
Verify the Service
Check if the service was created successfully:

bash
Copy
kubectl get services
Step 3: Use Port Forwarding to Access NGINX Service Locally
Set Up Port Forwarding
Use kubectl to forward the NGINX service to your local machine:

bash
Copy
kubectl port-forward svc/nginx-service 8080:80
Access NGINX Locally
Open your browser and navigate to http://localhost:8080. You should see the NGINX welcome page.

Step 4: Update NGINX Image to Apache
Update the Deployment to Use Apache
Edit the NGINX deployment to use the Apache HTTP Server image instead of NGINX:

bash
Copy
kubectl set image deployment/nginx-deployment nginx=httpd:latest
Verify the Update
Check the status of the deployment to ensure it was updated:

bash
Copy
kubectl rollout status deployment/nginx-deployment
Check Pods to Ensure Apache is Running
Verify that the NGINX containers were replaced by Apache containers:

bash
Copy
kubectl get pods
Access Apache Locally
Open your browser and navigate to http://localhost:8080. You should now see the Apache welcome page instead of the NGINX page.

Step 5: View Deployment's Rollout History
View Rollout History
To view the rollout history of the NGINX deployment, use the following command:

bash
Copy
kubectl rollout history deployment/nginx-deployment
This will show you all versions of the deployment, including the current and previous ones.

Step 6: Roll Back the NGINX Deployment to the Previous Image Version
Rollback the Deployment
To roll back the deployment to the previous NGINX version, use:

bash
Copy
kubectl rollout undo deployment/nginx-deployment
Verify the Rollback
Check the pods to ensure the deployment was rolled back to the previous version (NGINX):

bash
Copy
kubectl get pods
kubectl describe pod <nginx-pod-name>
Access NGINX Locally
Open your browser and navigate to http://localhost:8080. You should see the NGINX welcome page again.

Step 7: Monitor Pod Status
Monitor Pod Status in Real-Time
To monitor the status of your pods, use the -w flag to watch for changes:

bash
Copy
kubectl get pods -w
This will display real-time updates of the pods' status as they are created, updated, or deleted.

Describe a Pod for Detailed Information
To get more detailed information about a specific pod, use:

bash
Copy
kubectl describe pod <nginx-pod-name>
Conclusion
In this lab, you deployed an NGINX application with 3 replicas, exposed it using a service, updated it to use Apache, viewed the deployment's rollout history, and rolled it back to the previous version. You also monitored the pod statuses in real-time.
