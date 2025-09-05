# AdventureWorks data integration scenario
This repository is a learning scenario to practice data integration techniques based on the Microsoft's AdventureWorks database. It features an augmented partition of the original database that has three different sources: 

- **AdventureWorks Core MySQL**: A subset of the original AdventureWorks database ported to MySQL that doesn't include product review data or employee related data. 
- **AdventureWorks Reviews API**: A REST API to consume review data for products and stores of AdventureWorks. The description of the API can be accessed through `localhost:${REVIEW_API_PORT_MAP}/docs` or `localhost:${REVIEW_API_PORT_MAP}/redoc` .
- **AdventureWorks Employee Files**: An http server to consume CSV files of AdventureWorks employee related data.

## Quick Start


To use this first you need to clone the AdventureWorks reviews generator

```
git clone https://github.com/ISBIG-UH/adventureworks-reviews.git sources/reviews/generator
```

To run the generator

```
cd sources/reviews/generator
docker compose up
```

Then go to the project root and start the containers

```
docker compose up
```

## Configuration

All configurations of the compose file are set in the `.env` file in the project root

To customize the ports that are mapped to localhost you can modify the following variables

```
MYSQL_PORT_MAP=32000
REVIEW_API_PORT_MAP=8000
EMPLOYEE_SERVER_PORT_MAP=8080
```

The compose file use a default docker network for isolating the scenario which can be specified with the variable

```
DOCKER_NETWORK=adventure_works_network
```

**You must make sure the specified network exists**. You can create a Docker network with the command

```
docker network create adventure_works_network
```

## Disclaimer

This repository is intended for learning purposes only. We are not associated by any means with Microsoft or AdventureWorks trademarks.
