docker build --no-cache -t rivethead42/ghost:1 -f Dockerfile .
docker rm test-ghost
docker run --name test-ghost -dit rivethead42/ghost:1 /bin/bash
