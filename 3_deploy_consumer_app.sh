#Build and deploy client
cd ./client-app
gcloud config set project $1
gcloud builds submit --tag eu.gcr.io/$1/hooks-client

gcloud run deploy hooks-client --image eu.gcr.io/$1/hooks-client --platform managed --project $1 --region europe-west1 --allow-unauthenticated
cd ..