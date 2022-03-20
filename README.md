# sheltertech-go

This repository contains the beginnings of a Golang implementation of  https://github.com/ShelterTechSF/askdarcel-api/

## Testing

This repository requires running the docker-compose setup inside https://github.com/ShelterTechSF/askdarcel-api/blob/master/docker-compose.yml

The docker-compose in this repository links to the same docker network `askdarcel` and connects to the database defined at https://github.com/ShelterTechSF/askdarcel-api/blob/master/docker-compose.yml#L4

To start the server in the docker network
```
make run
```
To test
```
curl -s localhost:3001/api/categories | jq 
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