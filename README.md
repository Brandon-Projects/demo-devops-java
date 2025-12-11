🚀 DevOps End-to-End Platform – Spring Boot API on Docker, Kubernetes, Terraform & CI/CD

Autor: Brandon Estrada – DevOps Engineer | Cloud | IaC | CI/CD

Este proyecto demuestra un flujo moderno DevOps End-to-End utilizando contenedores, Kubernetes, infraestructura como código, automatización CI/CD y buenas prácticas de despliegue.

El objetivo fue construir, contenedorizAR, publicar y desplegar una API Java en un clúster Kubernetes, aplicando herramientas reales usadas en empresas de alto nivel (FinTech, banca digital, SaaS, etc.).

Incluye:

✔️ Spring Boot API (Java 17)
✔️ Docker multi-stage + Push a DockerHub
✔️ Kubernetes Deployment + Service + Ingress + HPA + ConfigMap + Secret
✔️ Terraform administrando recursos del clúster
✔️ CI/CD completo para build, push y apply infra
✔️ Prueba local vía NodePort y port-forward
✔️ Proyecto ejecutado completamente en WSL2 Ubuntu

🧱 1. Stack Tecnológico
| Capa                 | Tecnología                             |
| -------------------- | -------------------------------------- |
| Lenguaje             | Java 17                                |
| Framework            | Spring Boot 3.0.5                      |
| Base de datos        | H2 (in-memory) + schema.sql + data.sql |
| Build                | Maven                                  |
| Contenedores         | Docker                                 |
| Registro de imágenes | Docker Hub                             |
| Orquestación         | Kubernetes (kind)                      |
| IaC                  | Terraform 1.14                         |
| CI/CD                | GitHub Actions                         |
| Seguridad            | Trivy (image scanning)                 |

🧬 2. Arquitectura General
+---------------------------+         +-----------------------------+
| Developer Laptop (WSL2)  |         | KIND Kubernetes Cluster     |
|---------------------------|         |-----------------------------|
| mvn clean package        |         | Namespace: devsu            |
| docker build/push        |  --->   | Deployment: 2 replicas      |
| terraform apply          |         | Service NodePort            |
+---------------------------+         | Ingress (routing)           |
                                      | HPA (autoscaling)           |
                                      | ConfigMap + Secret          |
                                      +-----------------------------+
Registro:
Docker Hub → bsaulestradah/demo-devops-java:v1

🧪 3. Endpoint de prueba

La API expone un único endpoint:

GET /users

Respuesta esperada:
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

🐳 5. Docker Build & Push
docker build -t bsaulestradah/demo-devops-java:v1 .
docker push bsaulestradah/demo-devops-java:v1

☸️ 6. Despliegue Kubernetes con Terraform (Infraestructura como Código)

El clúster de Kubernetes se creó con kind:
kind create cluster --config kind-config.yaml

Terraform maneja:

✔️ Namespace
✔️ Deployment (2 replicas)
✔️ Service NodePort
✔️ Ingress controller
✔️ ConfigMap
✔️ Secret
✔️ Autoscaling con HPA

Ejecutar:

terraform init
terraform apply -auto-approve

🔍 7. Validación del despliegue
Pods
kubectl get pods -n devsu

Resultado esperado:
demo-devops-java-xxxx   1/1   Running
demo-devops-java-yyyy   1/1   Running

Service
kubectl get svc -n devsu


Ejemplo:
demo-service NodePort 80:30080/TCP

Probar desde la PC
curl http://localhost:30080/users

Salida real del proyecto:
[
  { "id": 1, "dni": "1234567890", "name": "Brandon Estrada" }
]

🏗️ 8. Estructura del repositorio
devsu-demo-devops-java/
│
├── src/                      # Código Java Spring Boot
│
├── Dockerfile                # Imagen multi-stage
│
├── k8s/                      # Manifests Kubernetes
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── configmap.yaml
│   └── secret.yaml
│
├── terraform/                # Infraestructura como Código
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── .github/workflows/
│   └── ci-cd.yml             # Pipeline GitHub Actions
│
└── README.md

🤖 9. CI/CD en GitHub Actions (Automatización Completa)

Pipeline configurado para:

✔️ Compilar con Maven
✔️ Escanear seguridad con Trivy
✔️ Construir imagen Docker
✔️ Empujar a Docker Hub
✔️ Ejecutar Terraform apply

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

🏁 10. Resultados Finales — Qué logramos

✔️ Aplicación Java funcional y completamente contenedorizada
✔️ Imagen Docker optimizada con multi-stage build
✔️ Despliegue robusto en Kubernetes con:

- Deployment
- Service
- Ingress
- Autoscaling (HPA)
- ConfigMap + Secret

✔️ Terraform como IaC administrando todos los recursos
✔️ CI/CD profesional listo para empresas
✔️ Proyecto totalmente reproducible en cualquier laptop

✨ Autor

Brandon Estrada
DevOps Engineer & Cloud Enthusiast
Diseñando soluciones reproducibles, escalables y seguras en Kubernetes + IaC + CI/CD.
