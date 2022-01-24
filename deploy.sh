docker build -t manish16399/multi-client:latest -t manish16399/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t manish16399/multi-server:latest -t manish16399/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t manish16399/multi-worker:latest -t manish16399/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push manish16399/multi-client:latest
docker push manish16399/multi-server:latest
docker push manish16399/multi-worker:latest

docker push manish16399/multi-client:$SHA
docker push manish16399/multi-server:$SHA
docker push manish16399/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=manish16399/multi-client:$SHA
kubectl set image deployments/server-deployment server=manish16399/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=manish16399/multi-worker:$SHA