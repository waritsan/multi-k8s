docker build -t waritsan/multi-client:latest -t waritsan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t waritsan/multi-server:latest -t waritsan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t waritsan/multi-worker:latest -t waritsan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push waritsan/multi-client:latest
docker push waritsan/multi-server:latest
docker push waritsan/multi-worker:latest

docker push waritsan/multi-client:$SHA
docker push waritsan/multi-server:$SHA
docker push waritsan/multi-worker:$SHA

kubectl apply -t k8s
kubectl set image deployments/server-deployment server=waritsan/multi-server:$SHA
kubectl set image deployments/client-deployment client=waritsan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=waritsan/multi-worker:$SHA