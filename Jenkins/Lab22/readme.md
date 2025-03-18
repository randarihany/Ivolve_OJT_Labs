

```
minikube status
```
![image](https://github.com/user-attachments/assets/6b8cd043-a29d-40ca-8cea-92d2421f0f63)

```
docker network ks
```
![image](https://github.com/user-attachments/assets/f5be9948-dce2-401a-83b0-a7d53f5400da)

```
docker run -d --name jenkins -p 8080:8080  -v jenkins_data2:/var/jenkins_home --network minikube jenkins/jenkins:lts
```

![image](https://github.com/user-attachments/assets/fe23e0d6-6892-439b-b457-4b4851428abc)

Go to http://localhost:8080/ , Create a new user , get the admin password , install suggested plugins.




