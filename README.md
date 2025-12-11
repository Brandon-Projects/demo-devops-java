🚀 DevOps End-to-End Platform – Spring Boot API on Docker, Kubernetes, Terraform & CI/CD

Autor: Brandon Estrada – DevOps Engineer | Cloud | IaC | CI/CD

Este proyecto demuestra un flujo DevOps moderno de extremo a extremo, integrando:
- Contenedores Docker
- Kubernetes (kind)
- Infraestructura como Código (Terraform)
- CI/CD profesional en GitHub Actions
- Escaneo de seguridad, autoscaling y buenas prácticas de despliegue

El objetivo es construir, contenedizar, publicar y desplegar una API en un clúster Kubernetes, siguiendo estándares usados en empresas FinTech, banca, SaaS y tecnología de alto nivel.

🧱 1. Stack Tecnológico
| Capa                 | Tecnología                             |
| -------------------- | -------------------------------------- |
| Lenguaje             | Java 17                                |
| Framework            | Spring Boot 3.0.5                      |
| Base de datos        | H2 (in-memory) + schema.sql + data.sql |
| Build                | Maven                                  |
| Contenedores         | Docker (multi-stage)                   |
| Registro de imágenes | Docker Hub                             |
| Orquestación         | Kubernetes (kind)                      |
| IaC                  | Terraform 1.14                         |
| CI/CD                | GitHub Actions                         |
| Seguridad            | Trivy (image scanning)                 |

🧬 2. Arquitectura General
+------------------------------+        +---------------------------------+
|     Developer Laptop (WSL2)  |        |      KIND Kubernetes Cluster     |
|------------------------------|        |---------------------------------|
| mvn clean package            |        | Namespace: devsu                |
| docker build / docker push   | ---->  | Deployment: 2 replicas          |
| terraform apply              |        | Service: NodePort (30080)       |
+------------------------------+        | Ingress routing                  |
                                        | HPA autoscaling                  |
                                        | ConfigMap + Secret               |
                                        +----------------------------------+
Registro de imágenes:
docker.io/bsaulestradah/demo-devops-java:v1

🧪 3. Endpoint de prueba

GET /users

Respuesta real del proyecto:

[
  { "id": 1, "dni": "1234567890", "name": "Brandon Estrada" },
  { "id": 2, "dni": "9876543210", "name": "Devsu Candidate" }
]

🧩 4. Build & Run Local (sin Kubernetes)
mvn clean package -DskipTests
docker build -t bsaulestradah/demo-devops-java:v1 .
docker run -p 8080:8080 bsaulestradah/demo-devops-java:v1


Probar:
curl http://localhost:8080/users

🐳 5. Publicar imagen en Docker Hub
docker build -t bsaulestradah/demo-devops-java:v1 .
docker push bsaulestradah/demo-devops-java:v1

☸️ 6. Despliegue Kubernetes con Terraform (IaC)
Crear clúster kind:
kind create cluster --config kind-config.yaml

Terraform administra:

✔ Namespace
✔ Deployment (réplicas)
✔ Service NodePort
✔ Ingress
✔ HPA autoscaling
✔ ConfigMap
✔ Secret

Aplicar infra:
terraform init
terraform apply -auto-approve

🔍 7. Validación del despliegue
Pods:
kubectl get pods -n devsu


Esperado:
demo-devops-java-xxxx   1/1   Running
demo-devops-java-yyyy   1/1   Running

Service:
kubectl get svc -n devsu


Ejemplo:
demo-service   NodePort   80:30080/TCP

Probar desde la PC:
curl http://localhost:30080/users

🏗️ 8. Estructura del Repositorio
devsu-demo-devops-java/
│
├── src/                       # Código Java Spring Boot
│
├── Dockerfile                 # Build multi-stage
│
├── k8s/                       # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── configmap.yaml
│   └── secret.yaml
│
├── terraform/                 # Infraestructura como Código
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── .github/workflows/
    └── ci-cd.yml              # Pipeline CI/CD

🤖 9. CI/CD en GitHub Actions

El pipeline realiza:

✔ Maven build
✔ Escaneo de seguridad con Trivy
✔ Docker build
✔ Push automático a Docker Hub
✔ Terraform apply

Fragmento del pipeline:
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

🏁 10. Resultados Finales — Qué se logró

✔ Aplicación Java funcional, contenedorizada y portable
✔ Imagen Docker optimizada con multi-stage
✔ Kubernetes desplegado con buenas prácticas:
 • Deployment
 • Service NodePort
 • Ingress
 • Autoscaling con HPA
 • ConfigMap + Secret
✔ Terraform gestionando toda la infraestructura
✔ Pipeline CI/CD listo para producción
✔ Proyecto totalmente reproducible en cualquier máquina

✨ Autor

Brandon Estrada
DevOps Engineer & Cloud Enthusiast
Diseñando soluciones reproducibles, escalables y seguras con Kubernetes + IaC + CI/CD.
