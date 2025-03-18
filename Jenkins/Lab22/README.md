### Lab 22: Jenkins Pipeline for Application Deployment
- Clone Dockerfile from: https://github.com/lbrahimAdell/App1.git
- Create a pipeline that automates the following processes:
- Bulld Docker Image from Dockertile in github
- push image to docker hub
- delete image locally.
- edit new image in deployment.yaml file.
- deplot to k8s.
Set pipeline post action (always, success, failure)

- run jenkins as a container
```
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_data:/var/jenkins_home jenkins/jenkins:lts
```
![image](https://github.com/user-attachments/assets/48c21e3f-df89-4a1c-9365-8720066ba57d)

![image](https://github.com/user-attachments/assets/1f6eca3f-ac7e-4f7a-ad8d-5984412bd047)

- install kubernetes plugin
- add new cloud

![image](https://github.com/user-attachments/assets/fcb6900b-50ab-4574-941f-09b7d7dc39bf)

- select secret file 
![image](https://github.com/user-attachments/assets/84a24cea-2713-4340-b901-902fd0855ce6)

- test connection trouble shooting

![image](https://github.com/user-attachments/assets/83b1e857-35a4-4218-84b6-18cbbc10c25f)

![image](https://github.com/user-attachments/assets/431fc46e-a772-4cfb-bdcf-6158741c1789)

```
ls /home/randa/.minikube/profiles/minikube/

```

![image](https://github.com/user-attachments/assets/33597738-37db-4845-ae6e-832f24245a86)

go to files and copy key inside config file directly instead of pointing on file

```
cat /home/randa/.minikube/ca.crt | base64 -w 0;echo
```

- final config file

![image](https://github.com/user-attachments/assets/442a0028-c0e9-40a7-8b55-0ff281579291)

- verify that config syntax is valid by running

```
kubectl cluster-info
```

![image](https://github.com/user-attachments/assets/fdbea181-dda2-4349-942f-ce7683787874)

![image](https://github.com/user-attachments/assets/16d385b7-02a8-4bce-a714-d90a8131175f)








