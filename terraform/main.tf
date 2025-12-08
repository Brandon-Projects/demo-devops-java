terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "devsu" {
  metadata {
    name = "devsu"
  }
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("${path.module}/../k8s/deployment.yaml"))
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("${path.module}/../k8s/service.yaml"))
}

resource "kubernetes_manifest" "configmap" {
  manifest = yamldecode(file("${path.module}/../k8s/configmap.yaml"))
}

resource "kubernetes_manifest" "secret" {
  manifest = yamldecode(file("${path.module}/../k8s/secret.yaml"))
}

resource "kubernetes_manifest" "hpa" {
  manifest = yamldecode(file("${path.module}/../k8s/hpa.yaml"))
}

resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(file("${path.module}/../k8s/ingress.yaml"))

  field_manager {
    force_conflicts = true
  }
}

