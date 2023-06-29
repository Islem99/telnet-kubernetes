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

Attendez que l’image soit correctement construite.

3 ème étape: Faire un "push" de l'image du Docker dans un registre de conteneurs dans notre cas Docker Hub

Avant de déployer l’image à Kubernetes, vous devez le pousser à un registre de conteneurs.

  *Identifiez l’image Docker avec le nom de registre et de dépôt souhaité en utilisant la commande suivante:
  
  > docker tag telnet-server your-registry/your-repository

  Dans notre cas : 
  > docker tag telnet-server islem1999/telnet-server

