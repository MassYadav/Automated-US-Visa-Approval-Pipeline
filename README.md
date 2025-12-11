# 🚀 US Visa Approval Prediction — End-to-End Production ML System  
FastAPI | Docker | Kubernetes (HPA) | AWS EC2/ECR | CI/CD | Evidently | MongoDB

---

## 🧩 1. Problem Statement  
This project predicts whether a US visa application will be **approved or rejected** using structured applicant features.  
It includes a **full production-grade ML system**:

- End-to-end ML pipeline (ingestion → validation → transformation → training → evaluation)
- FastAPI inference microservice
- Docker containerization
- Kubernetes deployment with **Horizontal Pod Autoscaler (HPA)**
- CI/CD for automated build → push → deploy
- AWS EC2 + ECR hosting
- MongoDB backend
- Evidently monitoring for drift detection

---

## 📁 2. Folder Structure  
```bash
.
├── k8s/                         # Kubernetes manifests (Deployment, Service, Namespace, HPA)
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── namespace.yaml
│   └── hpa.yaml
├── .github/
│   └── workflows/               # (Optional) GitHub Actions workflow for CI/CD
├── cloud_storage/               # Cloud utilities (S3)
├── components/                  # Modular ML components
├── config/                      # YAML configuration files
├── constants/                   # Global constants
├── data_access/                 # MongoDB / storage access
├── entity/                      # Config & artifact entity classes
├── exception/                   # Custom exception handler
├── flowcharts/                  # Architecture diagrams
├── logger/                      # Logging module
├── notebook/                    # Jupyter notebooks (EDA/training)
├── pipline/                     # Training + prediction pipelines
│   ├── training_pipeline.py
│   └── prediction_pipeline.py
├── static/                      # CSS / JS files
├── templates/                   # Jinja2 HTML templates
├── us_visa/                     # Core ML package
├── Dockerfile                   # Production dockerfile (Uvicorn + FastAPI)
├── app.py                       # FastAPI application (with /health endpoint)
├── requirements.txt
├── setup.py
└── README.md

⚙️ 3. High-Level Workflow 

constants → entity → components → pipeline → FastAPI → Docker → Kubernetes(HPA) → AWS Deployment


🌐 4. FastAPI Endpoints
GET /

Train Model
GET /train

Predict Visa Approval
POST /

Kubernetes Health Endpoint (Required)
GET /health

🔧 5. Run Project Locally
Create Conda Environment

conda create -n visa python=3.8 -y
conda activate visa


Install Dependencies
pip install -r requirements.txt

Export Environment Variables
export MONGODB_URL="mongodb+srv://<username>:<password>..."
export AWS_ACCESS_KEY_ID=<KEY>
export AWS_SECRET_ACCESS_KEY=<SECRET>

Run API with Uvicorn
uvicorn app:app --host 0.0.0.0 --port 8080

Swagger UI
http://localhost:8080/docs

🐳 6. Docker Usage
Build Image
docker build -t visa-app .

Run Container
docker run -p 8080:8080 visa-app

☸️ 7. Kubernetes Deployment (HPA Enabled)
Apply Manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/hpa.yaml

Verify Resources
kubectl get pods -n visa-system
kubectl get svc -n visa-system
kubectl get hpa -n visa-system

HPA Requirements

Install Metrics Server:

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

☁️ 8. AWS Deployment (EC2 + ECR + CI/CD)
Required IAM Permissions

AmazonEC2FullAccess

AmazonEC2ContainerRegistryFullAccess

Create ECR Repo
315865595366.dkr.ecr.us-east-1.amazonaws.com/visarepo

Install Docker on EC2
sudo apt update -y
sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu
newgrp docker

Add EC2 as Self-Hosted Runner

GitHub → Settings → Actions → Runners → Add Runner

Add GitHub Secrets
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
ECR_REPO

CI/CD Pipeline Performs:

Build Docker image

Push to ECR

SSH into EC2

Pull + run container

Restart service on new image

📊 9. Monitoring with Evidently

Tracks:

Data drift

Model drift

Feature distribution changes

Model performance decay

Great for real-time ML monitoring systems.

🔄 10. Git Commands
git add .
git commit -m "Updated K8s deployment + Docker + app config"
git push origin main

🔗 11. Important Links

GitHub Repo:
https://github.com/MassYadav/End-to-End-US-Visa-Approval-System

Live Demo:
http://127.0.0.1:64608 # k8n

http://54.147.165.235:8080 # aws


# 🚀 Kubernetes Deployment (Minikube + HPA)

# 1️⃣ Start Kubernetes Cluster
minikube start --driver=docker --cpus=4 --memory=8192

# 2️⃣ Verify Cluster
minikube status
kubectl get nodes
kubectl cluster-info

# 3️⃣ Enable Metrics Server (required for HPA)
minikube addons enable metrics-server
kubectl get deployment metrics-server -n kube-system
kubectl get pods -n kube-system

# 4️⃣ Use Minikube Docker Daemon
minikube -p minikube docker-env | Invoke-Expression

# 5️⃣ Build Docker Image INSIDE Minikube
docker build -t masssyadav/visa-ml:latest .
# OR load an already-built image:
# minikube image load masssyadav/visa-ml:latest

# 6️⃣ Apply Kubernetes Manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/hpa.yaml

# 7️⃣ Verify Pods, Service, and HPA
kubectl get pods -n visa-system
kubectl get svc -n visa-system
kubectl get hpa -n visa-system

# 8️⃣ Get External Service URL
minikube service visa-ml-service -n visa-system --url

# 9️⃣ (Optional) Restart Pods After Updating Image
kubectl rollout restart deployment/visa-ml-api -n visa-system
# OR force delete all pods
kubectl delete pod -n visa-system --all

# 🔟 (Optional) Test HPA Scaling (CPU Load Generator)
kubectl run -n visa-system load-generator --image=busybox --restart=Never -- \
  /bin/sh -c "while true; do dd if=/dev/zero of=/dev/null bs=1M count=1024; done"

kubectl get hpa -n visa-system -w

# Cleanup load generator
kubectl delete pod load-generator -n visa-system

# 1️⃣1️⃣ (Optional) Remove All K8s Resources
kubectl delete -f k8s/
minikube stop
minikube delete

---

## 📸 Deployment & Scaling Screenshots (Kubernetes + HPA)

### 1️⃣ Kubernetes Dashboard
![Kubernetes Dashboard](/images/k8s-dashboard.png)

### 2️⃣ FastAPI UI Running in Minikube
![Visa UI](/images/visa-ui.png)

### 3️⃣ Horizontal Pod Autoscaler (HPA) Scaling Pods
![HPA Scaling](/images/hpa-scaling.png)

### 4️⃣ Running Pods After Scaling
![Pods Running](/images/pods-running.png)

### 5️⃣ Docker Desktop Containers
![Docker Desktop](/images/docker-desktop.png)



