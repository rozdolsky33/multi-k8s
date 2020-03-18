docker build -t rozdolsky33/multi-client:latest -t rozdolsky33/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rozdolsky33/multi-server:latest -t rozdolsky33/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rozdolsky33/multi-worker:latest -t rozdolsky33/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rozdolsky33/multi-client:latest
docker push rozdolsky33/multi-server:latest
docker push rozdolsku33/multi-worker:latest

docker push rozdolsky33/multi-client:$SHA
docker push rozdolsky33/multi-server:$SHA
docker push rozdolsku33/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rozdolsky33/multi-server:$SHA
kubectl set image deployments/client-deployment client=rozdolsky33/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rozdolsky33/multi-worker:$SHA