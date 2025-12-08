🚀 DevOps Demo – Spring Boot API on Kubernetes with Terraform & CI/CD

Este proyecto demuestra un flujo completo DevOps End-to-End, implementado por Brandon Estrada, aplicando buenas prácticas de desarrollo, contenedores, Kubernetes, infraestructura como código y automatización CI/CD.

Incluye:

✔️ Aplicación Spring Boot (Java 17)

✔️ Docker build & push a Docker Hub

✔️ Despliegue en Kubernetes (kind) con Deployment, Service, Ingress, HPA, ConfigMap y Secret

✔️ Terraform gestionando los recursos del clúster

✔️ CI/CD listo para GitHub Actions con terraform apply automatizado

✔️ Pruebas del endpoint desde localhost vía NodePort

Todo fue construido, ejecutado y validado desde WSL (Ubuntu) en una laptop Windows.

🧱 1. Stack Tecnológico

| Capa                        | Tecnología                           |
| --------------------------- | ------------------------------------ |
| Lenguaje                    | Java 17                              |
| Framework                   | Spring Boot 3.0.5                    |
| Build                       | Maven                                |
| Contenedores                | Docker + Docker Hub                  |
| Orquestación                | Kubernetes (kind)                    |
| Infraestructura como Código | Terraform 1.14 + provider Kubernetes |
| CI/CD                       | GitHub Actions                       |

🧬 2. Arquitectura General
+---------------------------+         +-----------------------------+
|  Developer Laptop (WSL)   |         |  kind Cluster (Kubernetes) |
+------------+--------------+         +--------------+--------------+
             |                                   |
             | docker build / docker push        |
             | terraform apply                   |
             v                                   v
     Docker Hub: bsaulestradah/demo-devops-java:v1

                                         +--------------------------+
                                         | Namespace: devsu         |
                                         |--------------------------|
                                         | Deployment:              |
                                         |  - demo-devops-java      |
                                         |  - 2 replicas            |
                                         |--------------------------|
                                         | Service (NodePort):      |
                                         |  80 -> 8080 (30080)      |
                                         |--------------------------|
                                         | Ingress: / → service     |
                                         | HPA: autoscaling (CPU)   |
                                         +--------------------------+

🧪 3. Endpoint de prueba

La API expone:
GET /users

Respuesta:
[
  {
    "id": 1,
    "dni": "1234567890",
    "name": "Brandon Estrada"
  }
]

🧩 4. Build & Run Local (sin Kubernetes)

Para correr local:
mvn clean package -DskipTests
docker build -t bsaulestradah/demo-devops-java:v1 .
docker run -p 8080:8080 bsaulestradah/demo-devops-java:v1

Endpoint local:
curl -v http://localhost:8080/users

🐳 5. Docker Build & Push
docker build -t bsaulestradah/demo-devops-java:v1 .
docker push bsaulestradah/demo-devops-java:v1


☸️ 6. Despliegue Kubernetes con Terraform

El clúster se creó con:
kind create cluster --config kind-config.yaml

Se aplicaron recursos con:
terraform init
terraform apply

Recursos gestionados por Terraform:

- Namespace devsu
- Deployment (2 replicas)
- Service NodePort (30080)
- Ingress
- ConfigMap
- Secret
- HPA autoscaling

🔍 7. Validación del despliegue (kubectl)
kubectl get pods -n devsu
NAME                                READY   STATUS    AGE
demo-devops-java-xxxx               1/1     Running   ...
demo-devops-java-yyyy               1/1     Running   ...
kubectl get svc -n devsu
demo-service   NodePort   80:30080/TCP

🌐 8. Probar endpoint desde la PC (NodePort)
curl -v http://localhost:30080/users

Salida real del proyecto:
[
  {
    "id": 1,
    "dni": "1234567890",
    "name": "Brandon Estrada"
  }
]

🏗️ 9. Estructura del repositorio
devsu-demo-devops-java/
│
├── src/                # Código Java
├── Dockerfile
├── kind-config.yaml
│
├── k8s/                # Manifests Kubernetes
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── configmap.yaml
│   └── secret.yaml
│
├── terraform/
│   ├── main.tf         # Todos los recursos aplicados
│   ├── variables.tf
│   └── outputs.tf
│
└── README.md

🤖 10. CI/CD en GitHub Actions (Listo para activar)

Archivo sugerido: .github/workflows/ci-cd.yml

name: CI/CD Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Set up JDK 17
        uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'temurin'

      - name: Build with Maven
        run: mvn -B clean package -DskipTests

      - name: Docker login
        run: echo ${{ secrets.DOCKER_PASSWORD }} | docker login -u ${{ secrets.DOCKER_USERNAME }} --password-stdin

      - name: Build & Push image
        run: |
          docker build -t bsaulestradah/demo-devops-java:latest .
          docker push bsaulestradah/demo-devops-java:latest

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Terraform Init & Apply
        run: |
          terraform init
          terraform apply -auto-approve

Los secretos DOCKER_USERNAME, DOCKER_PASSWORD, y del Kubeconfig deben configurarse en GitHub → Settings → Secrets.

🏁 11. Resultados finales

- Aplicación compilada y contenedorizada.

- Clúster Kubernetes configurado profesionalmente.

- Despliegue reproducible con Terraform.

- HPA, Ingress, ConfigMap, Secret correctamente implementados.

- Pipeline CI/CD listo para integrarse.

- Documentación clara, completa y reproducible por cualquier persona

✨ Autor

Brandon Estrada
DevOps Engineer & Cloud Enthusiast
Aplicando buenas prácticas de IaC, Kubernetes y automatización profesional.
