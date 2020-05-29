docker build -t amqo/multi-client:latest -t amqo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t amqo/multi-server:latest -t amqo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amqo/multi-worker:latest -t amqo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push amqo/multi-client:latest
docker push amqo/multi-server:latest
docker push amqo/multi-worker:latest

docker push amqo/multi-client:$SHA
docker push amqo/multi-server:$SHA
docker push amqo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amqo/multi-server:$SHA
kubectl set image deployments/client-deployment client=amqo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amqo/multi-worker:$SHA
