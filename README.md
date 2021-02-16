# CorGAT Galaxy Docker

Docker Galaxy [CorGAT flavor](https://github.com/matteo14c/CorGAT) 

## How to use 

- Install Docker follow the [procedure](https://docs.docker.com/engine/install/)
- Run the container
  `docker run -d --privileged -p 8080:80 -p 8021:21 -p 8022:22 laniakeacloud/galaxy_corgat:20.05`
- Log into Galaxy at http://localhost:8080 username: `admin@galaxy.org` passwd: `password`

## references

https://github.com/bgruening/docker-galaxy-stable
