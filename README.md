# telnet-kubernetes

Prérequis:
Cluster Kubernetes : Dans notre cas nous avons déployer un cluster localement à l'aide de Minikube.
Un pod postgresql : Dans notre cas nous avons utilisé les pods postgresql déployés sur Kubernetes (voir cette repository pour voir le déploement de conteneur posgresql sur Kubenetes)

1 ère étape: La création de Dockerfile
Ajoutez le contenu suivant au fichier "Dockerfile"

```
FROM ubuntu:latest

RUN apt-get update && apt-get install -y telnet

CMD ["/bin/bash"]
```

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

*Exécuter un conteneur Docker nommé "telnetcontainer" basé sur l'image "telnet-server:latest" en utilisnat:

>docker container run -d -it --name container-name your-image:latest

Dans notre cas:

> docker container run -d -it --name telnetcontainer telnet-server:latest

Vérifier si le conteneur est créé en utilisant:

> docker ps

4 ème étape: Déployer l’image Docker sur Kubernetes :

Créer un fichier YAML de déploiement Kubernetes (par exemple, telnet-deployment.yaml) avec le contenu suivant: 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: telnet-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: telnet-server
  template:
    metadata:
      labels:
        app: telnet-server
    spec:
      containers:
      - name: telnet-server
        image: <your-registry/your-repository:tag>  /*Dans notre cas : islem1999/telnet-server:latest*/
        ports:
        - containerPort: 23

```

 Création d'un déploiement sur Kubernetes basé sur le fichier YAML spécifié.
 
 > kubectl apply -f telnet-deployment.yaml


 
