resource "kubernetes_deployment" "utils" {
  metadata {
    name = "utils"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "utils"
      }
    }

    template {
      metadata {
        labels = {
          app = "utils"
        }
      }

      spec {
        container {
          image = "ubuntu:latest"
          name  = "utils"

          command = ["/bin/sh", "-c", "--"]
          args    = ["apt-get update -y && apt-get install -y sudo iputils-ping jq dnsutils openssh-server ufw curl telnet git && useradd -m -s /bin/bash local && echo 'local:changeme' | chpasswd && echo 'local ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && echo 'AllowUsers local' >> /etc/ssh/sshd_config && mkdir -p /var/run/sshd && /usr/sbin/sshd && while true; do sleep 30; done;"]

          port {
            container_port = 22
            name           = "ssh-tcp"
            protocol       = "TCP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "ssh_tcp" {
  metadata {
    name      = "ssh-tcp"
  }

  spec {
    selector = {
      app = "utils"
    }

    port {
      port        = 22
      target_port = 22
      protocol    = "TCP"
      name        = "ssh-tcp"
    }

    type             = "LoadBalancer"
    session_affinity = "ClientIP"
    load_balancer_ip = "10.0.0.1"
  }
}
