#Docker

Step 1: build jar

Step 2: add Dockerfile

Step 3: buid image

```
docker build --tag=foodsaveradmin:0.0.1 
```

Step 4: run container

```
docker run -p 8081:8081 foodsaveradmin:0.0.1
```

(port trước là port container, port sau là port của host)

#Docker Compose

Step 1: create docker-compose.yml

Step 2: start docker-compose

```
docker-compose up -d --build
```

Step 3: stop docker-compose

```
docker-compose down
```

#Kubernetes (minikube)

Step 1: Start minikube

```
minikube start
```

Step 2: Check minikube status

```
minikube status
```

Step 3: Set up your Docker environment so that Docker on your computer uses the Docker daemon running inside Minikube.

```
@FOR /f "tokens=*" %i IN ('minikube docker-env --shell cmd') DO @%i
```

Step 4: Build Image Docker

```
docker build --tag=foodsaveradmin:0.0.1
```

Step 5:

```
kubectl apply -f k8s-deployment.yaml
```

Step 6:

```
kubectl apply -f k8s-service.yaml
```

