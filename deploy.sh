docker build -t phb95/multi-client:latest -t phb95/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phb95/multi-server:latest -t phb95/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phb95/multi-worker:latest -t phb95/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push phb95/multi-client:latest
docker push phb95/multi-server:latest
docker push phb95/multi-worker:latest

docker push phb95/multi-client:$SHA
docker push phb95/multi-server:$SHA
docker push phb95/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=phb95/multi-client:$SHA
kubectl set image deployments/server-deployment server=phb95/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=phb95/multi-worker:$SHA
