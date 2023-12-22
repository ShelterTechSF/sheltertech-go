# sheltertech-go

This repository contains the beginnings of a Golang implementation of  https://github.com/ShelterTechSF/askdarcel-api/

## Integrate with askdarcel-api and askdarcel-web stack

This repository requires running the docker-compose setup inside https://github.com/ShelterTechSF/askdarcel-api/blob/master/docker-compose.yml

The docker-compose in this repository links to the same docker network `askdarcel` and connects to the database defined at https://github.com/ShelterTechSF/askdarcel-api/blob/master/docker-compose.yml#L4

To start the server in the docker network connected to the existing askdarcel-web and askdarcel-api services
```
make run
```
To test, you just need to provide the `v2` path param in front of any existing API route for Rails API.
```
curl -s localhost:8080/api/v2/categories | jq
```

## Implementation

Currently supports
```
GET /api/categories
GET /api/categories/{id}
GET /api/categories/subcategories/{id}
GET /api/categories/featured
```

## Compare against Rails API
You can make the same API calls against the Rails API on port 3000 and compare
```
curl -s localhost:3000/categories | jq 
curl -s localhost:3000/categories/150 | jq 
curl -s localhost:3000/categories/subcategories/150 | jq 
curl -s localhost:3000/categories/featured | jq 
```