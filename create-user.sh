NAME=student1

mkdir ./tokens
mkdir ./certs

kubectl create namespace $NAME
kubectl apply -f object-counts.yaml -n $NAME
kubectl create sa $NAME-user -n $NAME

# Use https://github.com/mattrobenolt/jinja2-cli/blob/master/samples/environ.jinja2
jinja2 user-rbac.yaml.jinja -D name=$NAME > temp.yaml

kubectl create -f temp.yaml

SECRET=$(kubectl get sa student1 -n student1 -o jsonpath={.secrets..name})
# Get token
kubectl get secret $SECRET -n $NAME -o "jsonpath={.data.token}" | base64 -d > ./tokens/$NAME.tok 
# Get Cert
kubectl get secret $SECRET -n $NAME -o "jsonpath={.data['ca\.crt']}" > ./certs/$NAME.crt
