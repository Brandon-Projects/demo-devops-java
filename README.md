🚀 DevOps End-to-End Platform

Spring Boot API on Docker, Kubernetes, Terraform & CI/CD

Autor: Brandon Estrada
DevOps Engineer | Cloud | IaC | CI/CD

🧭 Executive Summary

Este proyecto demuestra un flujo DevOps moderno de extremo a extremo, diseñado bajo principios utilizados en entornos FinTech, banca y SaaS de alta criticidad.

La solución cubre todo el ciclo de vida de una aplicación:
- build
- contenedorización
- análisis de seguridad
- despliegue automatizado
- escalamiento
- operación en Kubernetes

El enfoque principal no es solo “hacer que funcione”, sino hacerlo reproducible, escalable, seguro y operable.

🧱 1. Stack Tecnológico
| Capa                        | Tecnología             |
| --------------------------- | ---------------------- |
| Lenguaje                    | Java 17                |
| Framework                   | Spring Boot 3.0.5      |
| Base de datos               | H2 (in-memory)         |
| Build                       | Maven                  |
| Contenedores                | Docker (multi-stage)   |
| Registro de imágenes        | Docker Hub             |
| Orquestación                | Kubernetes (kind)      |
| Infraestructura como Código | Terraform 1.14         |
| CI/CD                       | GitHub Actions         |
| Seguridad                   | Trivy (image scanning) |

🧬 2. Arquitectura General
┌───────────────────────────┐
│ Developer Workstation     │
│ (WSL2 + Docker + Terraform│
│ + GitHub Actions)         │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Docker Hub                │
│ (Image Registry)          │
│ demo-devops-java:v1       │
└─────────────┬─────────────┘
              │
              ▼
┌──────────────────────────────────────────┐
│ Kubernetes Cluster (kind)                 │
│ Namespace: devsu                          │
│                                          │
│  ┌───────────────┐   ┌───────────────┐  │
│  │ Pod (Replica) │   │ Pod (Replica) │  │
│  │ Spring Boot   │   │ Spring Boot   │  │
│  └───────┬───────┘   └───────┬───────┘  │
│          │                   │          │
│      ┌───▼───────────────────▼───┐      │
│      │ Service (NodePort)         │      │
│      └───────────┬───────────────┘      │
│                  │                      │
│            ┌─────▼─────┐                │
│            │ Ingress   │                │
│            └───────────┘                │
│                                          │
│ ConfigMap | Secret | HPA (Autoscaling)   │
└──────────────────────────────────────────┘
🧠 Componentes y Flujo

Developer Workstation
- Construye la app (Maven)
- Genera la imagen Docker
- Aplica infraestructura con Terraform
- CI/CD se ejecuta en GitHub Actions

Docker Hub
- Almacena la imagen versionada
- Fuente única de verdad para despliegues

Kubernetes (kind)
- Namespace aislado (devsu)
- Deployment con múltiples réplicas
- Service expone la aplicación
- Ingress gestiona routing
- HPA escala automáticamente
- ConfigMap y Secret desacoplan configuración

🧪 3. Endpoint de prueba

GET /users
Respuesta real:
[
  { "id": 1, "dni": "1234567890", "name": "Brandon Estrada" },
  { "id": 2, "dni": "9876543210", "name": "Devsu Candidate" }
]

🧩 4. Build & Run Local (sin Kubernetes)
mvn clean package -DskipTests
docker build -t bsaulestradah/demo-devops-java:v1 .
docker run -p 8080:8080 bsaulestradah/demo-devops-java:v1

Validar:

curl http://localhost:8080/users

☸️ 5. Infraestructura como Código (Terraform)

Terraform administra de forma declarativa:
✔ Namespace
✔ Deployment con réplicas
✔ Service NodePort
✔ Ingress
✔ Horizontal Pod Autoscaler
✔ ConfigMap
✔ Secret

Aplicación:
terraform init
terraform apply

Este enfoque permite reproducibilidad total del entorno, evitando configuraciones manuales.

📈 6. Escalabilidad y Alta Disponibilidad

- 2 réplicas mínimas
- Autoscaling horizontal (HPA) basado en CPU
- Preparado para crecer hasta 5 pods

Esto asegura:
- tolerancia a fallos
- balanceo de carga
- elasticidad bajo demanda

🤖 7. CI/CD con GitHub Actions

El pipeline implementa:

✔ Build con Maven
✔ Análisis de seguridad con Trivy
✔ Docker build
✔ Push automático a Docker Hub
✔ Infraestructura versionada

Pipeline definido como código en:
.github/workflows/ci.yml

Esto garantiza trazabilidad, auditabilidad y despliegues consistentes.

🔐 8. Seguridad y Buenas Prácticas

- Secretos gestionados vía Kubernetes Secrets
- Variables no hardcodeadas
- Imagen Docker multi-stage para reducir superficie de ataque
- Escaneo de vulnerabilidades integrado en CI

🧠 9. Decisiones Técnicas y Trade-offs

- Se utilizó Kubernetes local (kind) para facilitar reproducibilidad.
- NodePort y port-forward fueron elegidos para acceso local.
- Los secretos están codificados en base64 solo con fines demostrativos.

👉 En un entorno productivo:

- Se usaría LoadBalancer / Ingress Controller gestionado
- Se integrarían Secret Managers (Vault, AWS Secrets Manager)
- Se habilitaría TLS con certificados gestionados

🏁 10. Resultados Finales

✔ Aplicación Java funcional
✔ Dockerización optimizada
✔ Kubernetes con buenas prácticas
✔ Infraestructura como Código
✔ CI/CD automatizado
✔ Proyecto completamente reproducible

✨ Autor

Brandon Estrada
DevOps Engineer & Cloud Enthusiast

Diseñando soluciones reproducibles, escalables y seguras con Kubernetes, IaC y CI/CD.
