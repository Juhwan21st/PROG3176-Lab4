# Lab 4: Deploying a .NET Web API to Kubernetes (Minikube)

Course: PROG3176 - Winter 2026 - Section 1  
Student: Juhwan Seo [8819123]  
Date: Apr 6, 2026

---

## Description

A .NET 10 Web API with a `/hello` endpoint, containerized with Docker and deployed to Kubernetes using Minikube. Demonstrates deployment, service exposure via NodePort, scaling, and self-healing.

---

## Project Structure

| File / Folder | Description |
|---|---|
| `Program.cs` | Minimal API with `/hello` endpoint |
| `Dockerfile` | Multi-stage Docker build (SDK 10.0 -> ASP.NET 10.0) |
| `.dockerignore` | Excludes bin, obj, .git, .vs, .vscode |
| `deployment.yaml` | Kubernetes Deployment (2 replicas, `imagePullPolicy: Never`) |
| `service.yaml` | Kubernetes Service (NodePort 30080) |
| `screenshots/` | Step-by-step verification screenshots |

---

## API Endpoint

| Method | Endpoint | Response |
|---|---|---|
| GET | /hello | `Hello from Kubernetes!` |

---

## Step 1 - Local Test

```powershell
dotnet run
curl.exe http://localhost:5057/hello
```

![Local Test](screenshots/local_test.png)
<sub>File: screenshots/local_test.png</sub>

---

## Step 2 - Docker Build and Test

```powershell
docker build -t juhwanseo-kubeapi:latest .
docker run -p 8080:8080 juhwanseo-kubeapi:latest
curl.exe http://localhost:8080/hello
```

![Docker Test](screenshots/docker_test.png)
<sub>File: screenshots/docker_test.png</sub>

---

## Step 3 - Minikube Deployment

```powershell
minikube start
minikube image load juhwanseo-kubeapi:latest
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods
```

![Pods Running](screenshots/pods_running.png)
<sub>File: screenshots/pods_running.png</sub>

---

## Step 4 - API Test Through Minikube

```powershell
minikube service kubeapi-service --url
curl.exe http://<minikube-ip>:30080/hello
```

![K8s API Test](screenshots/k8s_api_test.png)
<sub>File: screenshots/k8s_api_test.png</sub>

---

## Step 5 - Scaling and Self-Healing

```powershell
kubectl scale deployment kubeapi-deployment --replicas=5
kubectl get pods
kubectl delete pod <pod-name>
kubectl get pods
```

![Scaled 5 Pods](screenshots/scaled_5pods.png)
<sub>File: screenshots/scaled_5pods.png</sub>

![Self Healing](screenshots/self_healing.png)
<sub>File: screenshots/self_healing.png</sub>

---

## Git Commit History

| # | Message | Hash |
|---|---------|------|
| 1 | Initial project setup | — |
| 2 | Added Dockerfile | — |
| 3 | Added Kubernetes manifests | — |
| 4 | Verified Kubernetes deployment | — |
| 5 | Tested scaling and self-healing | — |
| 6 | Final version with README | — |