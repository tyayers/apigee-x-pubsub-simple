apt-get update
apt-get -y install nodejs npm zip jq
gcloud auth activate-service-account --project=$PROJECT --key-file=$KEY
access_token=$(gcloud auth print-access-token)    
cd proxies/locationproxy
zip -r locationproxy.zip apiproxy
DEPLOYRESULT=$(curl -X POST -H "Content-Type:multipart/form-data" -H "Authorization:Bearer $access_token" -F "file=@\"./locationproxy.zip\" type=application/zip;filename=\"locationproxy.zip\"" 'https://apigee.googleapis.com/v1/organizations/bruno-1407a/apis?name=LocationService&action=import')
REVISION=$(jq '.revision' <<< "$DEPLOYRESULT")
NEWREV="${REVISION%\"}"
NEWREV="${NEWREV#\"}"
gcloud apigee apis deploy $NEWREV --environment=test1 --api=LocationService --override
