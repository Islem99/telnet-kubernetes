#!/bin/bash

# Step 1: Create the Dockerfile
cat <<EOF >Dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y telnet

CMD ["/bin/bash"]
EOF

docker build -t telnet-server .

docker images

docker login -u <username> -p <password> docker.io

docker tag telnet-server islem1999/telnet-server

docker push islem1999/telnet-server

docker container run -d -it --name telnetcontainer telnet-server:latest

docker ps

cat <<EOF >telnet-deployment.yaml

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

EOF

kubectl apply -f telnet-deployment.yaml

cat <<EOF >telnet-service.yaml
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
EOF

kubectl apply -f telnet-service.yaml



kubectl get pods