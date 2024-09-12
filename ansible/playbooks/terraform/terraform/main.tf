data "external" "local_ip_address" {
  program = ["bash", "-c", "echo '{\"ip\": \"$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -n 1)\"}'"]
}

data "external" "external_ip_address" {
  program = ["bash", "-c", "echo '{\"ip\": \"$(curl -s https://api.ipify.org)\"}'"]
}

resource "null_resource" "minikube_installation" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Minikube indiriliyor."
      curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

      echo "Minikube kuruluyor.."
      sudo install minikube-linux-amd64 /usr/local/bin/minikube
      sudo rm -r /tmp/*

      echo "Minikube Docker ile başlatılıyor"
      sudo minikube start --driver=docker --listen-address='0.0.0.0' --apiserver-ips=172.31.19.31,18.184.53.226 --force

      echo "Minikube kurulumu tamamlandı."
    EOT
  }
}
