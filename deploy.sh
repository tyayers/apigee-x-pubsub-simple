#Build and deploy client
docker build -t local/webhook-client ./webhook-client
docker tag local/webhook-client eu.gcr.io/$1/webhook-client
docker push eu.gcr.io/$1/webhook-client

gcloud run deploy webhook-client --image eu.gcr.io/$1/webhook-client --platform managed --project $1 --region europe-west1 --no-allow-unauthenticated
