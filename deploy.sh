
echo "Removing stack..."
DEPLOYMENT_NAMESPACE=gatem
docker stack rm $DEPLOYMENT_NAMESPACE
limit=15

echo "Waiting for stack to be removed..."
until [ -z "$(docker service ls --filter label=com.docker.stack.namespace=$DEPLOYMENT_NAMESPACE -q)" ] || [ "$limit" -lt 0 ]; do
  sleep 2
  limit="$((limit-1))"
done
limit=15;
until [ -z "$(docker network ls --filter label=com.docker.stack.namespace=$DEPLOYMENT_NAMESPACE -q)" ] || [ "$limit" -lt 0 ]; do
  sleep 2;
  limit="$((limit-1))";
done


  echo "Building image ..."
  docker build . -f Dockerfile -t papa


echo "Deploying stack"
docker stack deploy $DEPLOYMENT_NAMESPACE -c docker-compose.yaml --resolve-image always

# docker service logs saal_courses -f