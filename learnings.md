# Learnings

## Useful Commands

### Docker

#### Build

Executed in same directory as Dockerfile.

Generic: `docker build . -t [image]:[tag]`
Specific: `docker build . -t ezchang/ezramchang:0.0.6`

#### Push

Generic: `docker push [image]:[tag]`
Specific: `docker push ezchang/ezramchang:0.0.6`

#### Pull

Generic: `docker pull [image]:[tag]`
Specific: `docker pull ezchang/ezramchang:0.0.6`

#### Run

Generic: `docker run -p [ipv4_port]:[ipv6_port] [image]:[tag]`
Specific: `docker run -p 4567:4567 ezchang/ezramchang:0.0.6`

#### List all containers

`docker ps --all`

#### Stop/Kill a container

`docker stop [container_id]`
`docker kill [container_id]`

#### Remove a container

`docker rm [container_id]`

### Nginx

`service nginx restart`

## Other Documentation

### Nginx

[nginx.conf][1]

[1]: https://github.com/emchang3/ezramchang/blob/master/nginx.conf
