gcloud config set project $1

gcloud pubsub topics create suppliers
gcloud pubsub topics create customers
gcloud pubsub topics create orders