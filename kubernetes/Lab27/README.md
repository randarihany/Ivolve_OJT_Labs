# Lab 27: Deployment vs. StatefulSet
- ﻿﻿Make a Comparison between Deployment and Statefulset.
- ﻿﻿Create a YAML file for a MySQL Statefulset configuration with 3 replicas.
- ﻿﻿Write a YAML file to define a service for the MySQL Statefulset.

---

:blue_circle: 1 Deployment vs. StatefulSet Comparison: 

## StatefulSets:
- Designed for running stateful components of an app.
- Creates a set of identically configured Pods with unique, non-interchangeable identities.
- Each Pod is assigned its own persistent storage volume, which is reattached on restarts.
- Suitable for applications that require stable network identities and storage persistence (e.g., databases).
- Allows other applications to reliably interact with the primary instance.
- 
## Deployments:
- Used for running stateless applications.
- Benefits from declarative updates and rollbacks.
- The Deployment controller handles orchestration, allocating Pods to the most appropriate Nodes.

![image](https://github.com/user-attachments/assets/a1da9bad-8d76-49be-b771-b540a2ce1319)

:blue_circle: Create a YAML File for MySQL StatefulSet with 3 Replicas
YAML configuration for creating a StatefulSet for a MySQL database with 3 replicas.

:blue_circle: Write a YAML File to Define a Service for the MySQL StatefulSet
To enable the pods in the StatefulSet to communicate with each other and be accessible externally (if necessary), you need to define a service. 
YAML file to define a headless service for the StatefulSet.

- Deploy the StatefulSet and Service:
```
kubectl apply -f mysql-statefulset.yaml
kubectl apply -f mysql-service.yaml
```
- Verify the StatefulSet and Service:
```
kubectl get pods -l app=mysql
kubectl get service mysql
```

![image](https://github.com/user-attachments/assets/ff78fc3a-0b3f-4a13-80cf-b321d1c7dbe5)

- Access the MySQL StatefulSet:
```
kubectl exec -it mysql-0 -- mysql -u root -p
```

![image](https://github.com/user-attachments/assets/5d609f90-b89a-4032-bbce-77a811e6b7f2)

