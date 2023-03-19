provider "kubernetes" {
  config_path    = "~/.kube/config"

}

#--------------------CREATE ALL NAMESPACES----------------------------------#
resource "kubernetes_namespace" "wandek8s-nodejs" {
  metadata {
    name = "wandek8s-nodejs"
  }
}

resource "kubernetes_namespace" "wandek8s-monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_namespace" "wandek8s-socksshop" {
  metadata {
    name = "sock-shop"
  }
}

resource "kubernetes_deployment" "wandek8s-nodejs" {
  metadata {
    name      = "wandek8s-nodejs"
    namespace = kubernetes_namespace.wandek8s-nodejs.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "wandek8s-nodejs"
      }
    }
    template {
      metadata {
        labels = {
          app = "wandek8s-nodejs"
        }
      }
      spec {
        container {
          image = "learnk8s/knote-js:1.0.0"
          name  = "wandek8s-nodejs-container"
          port {
            container_port = 80
          }
          env {
              name = "MONGO_URL"
              value = "mongodb://mongo:27017/dev"

        }

      }
    }
  }
}
}

resource "kubernetes_service" "wandek8s-nodejs" {
  metadata {
    name      = "wandek8s-nodejs"
    namespace = kubernetes_namespace.wandek8s-nodejs.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.wandek8s-nodejs.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = 3000
    }
  }
}

resource "kubernetes_deployment" "mongo" {
  metadata {
    name      = "mongo"
    namespace = kubernetes_namespace.wandek8s-nodejs.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mongo"
      }
    }
    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }
      spec {
        container {
          image = "mongo:3.6.17-xenial"
          name  = "mongo-container"
          port {
            container_port = 27017
          }
      }
    }
  }
}
}


resource "kubernetes_service" "mongo" {
  metadata {
    name      = "mongo"
    namespace = kubernetes_namespace.wandek8s-nodejs.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.mongo.spec.0.template.0.metadata.0.labels.app
    }
    type = "ClusterIP"
    port {
      port        = 27017
      target_port = 27017
    }
  }
}