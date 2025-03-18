# Lab 29: Security and RBAC
- Create a Service Account with token.
- Define a Role named pod-reader allowing read-only access to pods in the namespace.
- Bind the pod-reader Role to the Service Account.
- Make a Comparison between service account - role & role binding - and cluster role & cluster role binding.

---

### Creating a Service Account with a Token
- Create the Service Account:

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: service-account
  namespace: default
```
- Generate a Token for the Service Account:(manully generate token)

```
apiVersion: v1
kind: Secret
metadata:
  name: service-account-token
  annotations:
    kubernetes.io/service-account.name: service-account
type: kubernetes.io/service-account-token
```

- Apply Service Account:
  
```
kubectl apply -f serviceaccount.yaml
kubectl apply -f service-account-token.yaml
kubectl describe serviceaccount service-account -n default
```

You can get the token by running:

```
kubectl describe serviceaccount my-service-account -n default
``

![image](https://github.com/user-attachments/assets/c56f6a59-50fd-4001-b08d-ccb78aa8f3a2)

### Defining a Role Named pod-reader:

Create a role named pod-reader that gives read-only access to Pods in a namespace.

``
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

```
kubectl apply -f role-pod-reader.yaml
```

This Role grants get and list permissions for Pods in the default namespace.
Binding the pod-reader Role to the Service Account
To bind the pod-reader Role to the my-service-account Service Account, you need a RoleBinding. 
The RoleBinding grants the permissions defined in the Role to the Service Account.

### Create the RoleBinding:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: default
subjects:
- kind: ServiceAccount
  name: my-service-account
  namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
- Apply:
```
kubectl apply -f rolebinding-pod-reader.yaml
```
This RoleBinding will allow my-service-account to access Pods in the default namespace with get and list permissions.
