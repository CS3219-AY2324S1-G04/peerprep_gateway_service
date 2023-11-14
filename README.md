# PeerPrep Gateway Service

Gateway to the services.

During deployment, this is the single point of entry for the front-end to access all services in the back-end. Endpoints that should not be accessible to the front-end are blocked by the gateway service.

## Deployment

Note that unlike other services, the Gateway Service's Kubernetes deployment and Docker compose deployment are completely unrelated. That is to say, the image use for Docker compose deployment is not used for Kubernetes deployment.

### Kubernetes Deployment

This is the main deployment method for production.

**Prerequisite**

- Kubernetes cluster must be setup as specified in the [main repository](https://github.com/CS3219-AY2324S1/ay2324s1-course-assessment-g04#deployment).
- All services must be deployed within the Kubernetes cluster.
  - It is possible to only deploy specific services. Requests to endpoints for services that are not deployed will not be forwarded.

**Steps:**

1. Ensure the "peerprep" namespace has been created: `kubectl create namespace peerprep`
2. Navigate to the "kubernetes" directory: `cd kubernetes`
3. Deploy the Kubernetes objects: `./deploy.sh`
    - To delete the Kubernetes objects, run: `./delete.sh`

### Docker Compose Deployment

This is intended for development use only. It is meant to make developing other services easier.

**Prerequisite**

- All services must be deployed via Docker compose.
  - It is possible to only deploy specific services. Requests to endpoints for services that are not deployed will not be forwarded.

**Steps:**

1. Navigate to the "docker" directory: `cd docker`
2. Ensure that the "peerprep" network exist: `docker network create -d bridge peerprep`
3. Build the docker images and create the docker containers: `docker compose up --build`
    - To delete the docker containers, run: `docker compose down`

## Proxy Paths

Proxying is done via path prefix. If none of the following prefixes are a match, the request will be forwarded to Webpage Service.

### User Service

> /user-service

### Question Service

> /question-service

### Matching Service

> /matching-service

### Room Service

> /room-service

The exact path `/room-service/rooms/` is blocked. A HTTP 403 error will be returned.

### Editor Service

> /editor-service

### Chat Service

> /chat-service

### Attempt History Service

> /attempt-history-service

The exact path `/attempt-history-service/add/` is blocked. A HTTP 403 error will be returned.

### Docs Service

> /docs-service

### Webpage Service

> /webpage-service
