# telnet-kubernetes

Prérequis:
-Cluster Kubernetes : Dans notre cas nous avons déployé un cluster localement à l'aide de Minikube.

-Un pod postgresql : Dans notre cas nous avons utilisé les pods postgresql déployés sur Kubernetes (pour voir le déploiement de conteneur posgresql sur Kubenetes suivez cette repository > https://github.com/Islem99/postgresql-kubernetes)

###Avant d'éxécuter le script "telnet-deployment.sh" changer le nom d'utilisateur et le mot de passe de votre compte "Docker Hub"

docker login -u [username] -p [password] docker.io

#1 ère étape: La création de Dockerfile
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

#2 ème étape:
*Faire un build pour construire l'image Docker "telnet-server" en utilisant cette commande:

> docker build -t telnet-server .

![build](https://github.com/Islem99/telnet-kubernetes/assets/84632827/fb990b2d-1e77-4358-9224-b3fdc8033f27)

*Attendez que l’image soit correctement construite et vérifiez la construction de l'image en utilisant la commande suivante:

> docker images

![image](https://github.com/Islem99/telnet-kubernetes/assets/84632827/568d7ffa-05a1-4b49-9271-c439359a712f)

#3 ème étape : Authentification au compte Docker en utlisant la commande:

> docker login

![login](https://github.com/Islem99/telnet-kubernetes/assets/84632827/694dcd38-688d-4200-af58-e2239a5b56e9)


#4 ème étape: Faire un "push" de l'image du Docker dans un registre de conteneurs dans notre cas Docker Hub

Avant de déployer l’image à Kubernetes, vous devez le pousser à un registre de conteneurs.

  *Identifiez l’image Docker avec le nom de registre et de dépôt souhaité en utilisant la commande suivante:
  
  > docker tag telnet-server your-registry/your-repository

  Dans notre cas : 
  > docker tag telnet-server islem1999/telnet-server

*Faire un "push" de l'image du Docker dans Docker Hub en utilisant:

docker push your-registry/your-repository:tag

dans notre cas :
> docker push islem1999/telnet-server

![image](https://github.com/Islem99/telnet-kubernetes/assets/84632827/21e42230-6167-4556-9956-0b74eacb5e11)


*Exécuter un conteneur Docker nommé "telnetcontainer" basé sur l'image "telnet-server:latest" en utilisnat:

>docker container run -d -it --name container-name your-image:latest

Dans notre cas:

> docker container run -d -it --name telnetcontainer telnet-server:latest

![run](https://github.com/Islem99/telnet-kubernetes/assets/84632827/ed6d66db-487a-4fa1-b466-227d4ba9a1da)


Vérifier si le conteneur est créé en utilisant:

> docker ps

#5 ème étape: Déployer l’image Docker sur Kubernetes :

*Créer un fichier YAML de déploiement Kubernetes (par exemple, telnet-deployment.yaml) avec le contenu suivant: 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: telnet-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: telnet
  template:
    metadata:
      labels:
        app: telnet
    spec:
      containers:
        - name: telnet-container
          image: islem1999/telnet-pod:latest
          ports:
            - containerPort: 23
          command: ["sleep"]
          args: ["infinity"]


```

 *Création d'un déploiement sur Kubernetes basé sur le fichier YAML spécifié.
 
 > kubectl apply -f telnet-deployment.yaml

*Vérification de l'état de pod:

> kubectl get pod

![final](https://github.com/Islem99/telnet-kubernetes/assets/84632827/6b6c1559-3b37-490c-b464-76b117c86575)

#6 ème étape : Exposer le service Telnet :

*Créer un fichier YAML de service (par exemple telnet-service.yaml) avec le contenu suivant :

```
apiVersion: v1
kind: Service
metadata:
  name: telnet-service
spec:
  selector:
    app: telnet-app
  ports:
    - protocol: TCP
      port: 23
      targetPort: 23
  type: ClusterIP
```

*Appliquer le service à Kubernetes:

Exécutez la commande suivante pour appliquer le service à votre cluster Kubernetes :

> kubectl apply -f telnet-service.yaml

Vérifier le service :

*Exécuter la commande suivante pour vérifier l’état du service :

> kubectl get services

#Test de connexion telnet: 

Pour tester la connexion de pod telnet au pod postgresql vous entrez au conteneur telnet et vous testez la connexion :

*vous vérifiez les adresses ip des pods posgresql d'abord en utilisant la commande:

> kubectl get pods -o wide

![image](https://github.com/Islem99/telnet-kubernetes/assets/84632827/e3b7517b-92ac-4688-bcb0-02c9ced7e5f9)


*Puis vous testez la connexion: 

![telnet-test](https://github.com/Islem99/telnet-kubernetes/assets/84632827/4c23f8b9-c886-4e44-9c22-fa87ab291d97)




 
