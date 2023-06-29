# telnet-kubernetes

Prérequis:
Cluster Kubernetes : Dans notre cas nous avons déployer un cluster localement à l'aide de Minikube.
Un pod postgresql : Dans notre cas nous avons utilisé les pods postgresql déployés sur Kubernetes (voir cette repository pour voir le déploement de conteneur posgresql sur Kubenetes)

1 ère étape: La création de Dockerfile
Ajoutez le contenu suivant au fichier "Dockerfile"

> FROM ubuntu:latest

> RUN apt-get update && apt-get install -y telnet

> CMD ["/bin/bash"]

Enregistrer Dockerfile.

2 ème étape:
Faire un build pour construire l'image Docker "telnet-server" en utilisant cette commande:

> docker build -t telnet-server .
