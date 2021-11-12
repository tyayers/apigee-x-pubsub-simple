# apigee-x-pubsub-simple-eventing

This project shows how to create a simple, scalable eventing platform using the Google Cloud services Apigee X and Pub/Sub.

## Try it out

You can try this solution out by visiting this sample [Developer Portal]() and clicking the **Webhooks** link in the header menu with easy to follow instructions on how to become either a producer or subscriber of events.  

Here is a [test client app](https://hooks-client-h7pi7igbcq-ew.a.run.app/) which is subscribed to **supplier** events, and will display all events as they are broadcast in real-time.

## Architecture

![Architecture](/img/architecture.png)

## Deploy it yourself

To deploy it yourself, first make sure you have an Apigee and SSH environment logged into **gcloud**.

Then execute the 3 scripts here to deploy the different components with your GCP project as parameter.

1. Create PubSub topics

```ssh
./1_create_pubsub_topics.ssh PROJECT_ID
```

2. Deploy Apigee X proxies

```ssh
./2_deploy_apigee-x-proxy.ssh PROJECT_ID
```

3. Deploy test app

```ssh
./3_deploy_consumer_app.ssh PROJECT_ID
```