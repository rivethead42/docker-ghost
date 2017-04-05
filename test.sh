docker build --no-cache -t rivethead42/ghost:1 -f Dockerfile .
docker tag rivethead42/ghost:1 rivethead42/ghost:latest

docker rm -f test-ghost
docker run --name test-ghost -dit rivethead42/ghost:1 /bin/bash
