NAME=student1
API=35.231.184.145
TOKEN=$(cat tokens/student1.tok)
CERT=$(cat certs/student1.crt)

mkdir ./kube-configs
jinja2 kube-config.yaml.jinja -D name=$NAME -D cert_data=$CERT -D token=$TOKEN -D k8s_api=$API > kube-configs/$NAME.yaml
