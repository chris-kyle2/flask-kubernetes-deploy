# Flask Kubernetes Deployment Project 🚀

This repository showcases a complete solution for deploying a Flask application on Kubernetes, leveraging CI/CD pipelines with GitHub Actions, Docker, and Infrastructure-as-Code principles using Terraform. The project spans local development with Minikube, cloud deployment with AWS EKS, and monitoring for seamless application performance.

---

## Repository Structure 🔀

```plaintext
.
├── .github/workflows
│   └── build-and-deploy.yml      # CI/CD pipeline for Docker image build, push, and Kubernetes deployment
├── Terraform
│   ├── .terraform.lock.hcl       # Lock file ensuring consistent Terraform provider versions
│   ├── eks.tf                    # Provisions an EKS cluster on AWS
│   ├── outputs.tf                # Outputs key information like VPC ID, subnets, etc.
│   ├── sg.tf                     # Security group configuration for the EKS cluster and app
│   ├── variables.tf              # Input variables for customizable Terraform configurations
│   ├── versions.tf               # Specifies required Terraform and provider versions
│   └── vpc.tf                    # VPC, subnet, and networking setup for AWS infrastructure
├── .gitignore                    # Specifies files and directories to exclude from version control
├── Dockerfile                    # Steps to build the Flask app's Docker image
├── app.py                        # Source code of the Flask application
├── deployment-service.yaml       # Kubernetes Deployment and Service definitions for the Flask app
├── install_docker.sh             # Script for installing Docker on a Linux machine
├── mini_kube_solution.sh         # Script to set up Minikube, kubectl, and deploy the app locally
├── python_script.py              # Python script to monitor Kubernetes pods and fetch logs for issues
├── requirements.txt              # Python dependencies for the Flask app
└── README.md                     # This documentation file
```

---

## Project Overview 🎯

This project is divided into three main tasks, designed to streamline the development, deployment, and monitoring of a Flask application:

### **Task 1: Kubernetes and Python**

1. **Python Monitoring Script (`python_script.py`)**  
   - Connects to a Kubernetes cluster.
   - Lists all running pods in a specific namespace.
   - Identifies pods not in the `Running` state and fetches their logs.
   - Logs are saved to individual files named `<pod-name>-logs.txt`.

2. **Flask Application (`app.py`)**  
   - A simple Flask app that returns `Hello, World!` when accessed via HTTP.
   - Dockerized using the `Dockerfile` for containerized deployment.

3. **Kubernetes YAML Definition (`deployment-service.yaml`)**  
   - Deployment: Manages pod replicas of the Flask app.
   - Service: Configures a LoadBalancer to expose the application via a public URL.
   - Retrieve the app's public endpoint by running:
     ```bash
     kubectl get svc flask-app-service
     ```

---

### **Task 2: GitHub Actions and Linux**

1. **CI/CD Pipeline (`.github/workflows/build-and-deploy.yml`)**  
   - **Automated Docker Build and Push**  
     - Builds the Flask app Docker image with a Git commit-based tag.
     - Pushes the image to Docker Hub.
   - **Automated Kubernetes Deployment**  
     - Deploys the app to the EKS cluster using `kubectl apply`.
     - Checks deployment status with `kubectl rollout`.
   - **Error Notification**  
     - Sends a Slack notification or logs an error message if the deployment fails.

2. **Local Minikube Setup (`mini_kube_solution.sh`)**  
   - Automates the installation of Minikube and kubectl.
   - Deploys the Flask app locally using the Kubernetes YAML file.

3. **Docker Installation Script (`install_docker.sh`)**  
   - Provides a one-command solution to install Docker on a Linux environment.

---

### **Task 3: Cloud Platform Integration**

1. **Infrastructure as Code with Terraform (`Terraform/`)**  
   - Provisions a production-grade EKS cluster on AWS.
   - Sets up a secure VPC with subnets and routing configurations.
   - Configures security groups to allow external traffic to the Flask application.
   - Outputs information about the infrastructure after deployment.

2. **Deployment and Public Access**  
   - After the GitHub Actions workflow completes, retrieve the public URL for the Flask application by running:
     ```bash
     kubectl get svc flask-app-service
     ```
   - The URL will be listed under the `EXTERNAL-IP` column.

3. **Application Monitoring**  
   - Basic monitoring is set up using AWS CloudWatch to track:
     - Application health
     - CPU and memory usage
   - A CloudWatch dashboard displays real-time metrics.

---

## Instructions 🔧

### **Run Locally with Minikube**

1. **Install Docker**:
   ```bash
   bash install_docker.sh
   ```
2. **Set Up Minikube and Deploy the App**:
   ```bash
   bash mini_kube_solution.sh
   ```
3. Access the app via the Minikube IP and NodePort:
   ```bash
   minikube service flask-app-service --url
   ```

---

### **Deploy to AWS using GitHub Actions**

1. Push your changes to the `main` branch to trigger the workflow.
2. The CI/CD pipeline will:
   - Build and push the Flask app Docker image to Docker Hub.
   - Deploy the app to the EKS cluster using Kubernetes manifests.
3. Verify the deployment:
   ```bash
   kubectl get svc flask-app-service
   ```
4. Access the app via the LoadBalancer's public endpoint.

---

## File Descriptions 📘

| File/Directory                 | Description                                                                 |
|--------------------------------|-----------------------------------------------------------------------------|
| `.github/workflows`            | Contains the GitHub Actions CI/CD workflows.                               |
| `Terraform/eks.tf`             | Defines the EKS cluster provisioning.                                      |
| `Terraform/vpc.tf`             | Configures the AWS VPC and subnets.                                        |
| `Terraform/sg.tf`              | Sets up security groups for the EKS cluster and application.               |
| `Dockerfile`                   | Contains steps to build the Flask app Docker image.                        |
| `app.py`                       | Flask application code that returns `Hello, World!`.                       |
| `deployment-service.yaml`      | Kubernetes Deployment and Service definitions for the Flask app.            |
| `python_script.py`             | Monitors pod statuses and fetches logs for pods in error states.           |
| `install_docker.sh`            | Script for installing Docker on Linux.                                     |
| `mini_kube_solution.sh`        | Automates local Minikube setup and deployment.                             |
| `requirements.txt`             | Python dependencies for the Flask app.                                     |

---

## Contact 📧

If you have any questions or encounter issues, please open an issue or reach out via this repository.

