#Build and deploy client
PROJECT_ID=$(gcloud config get-value project)
cd ./client-app
gcloud builds submit --tag eu.gcr.io/$PROJECT_ID/hooks-client

gcloud run deploy hooks-client --image eu.gcr.io/$PROJECT_ID/hooks-client --platform managed --project $PROJECT_ID --region europe-west1 --allow-unauthenticated
cd ..