if [ -z "$1" ]; then
  echo "Please provide an argument with the environment"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Please provide an argument with the registry image"
  exit 1
fi

# $3 which is tag can be empty

export CI_REGISTRY_IMAGE=$2
export tag=$3
envsubst < templates/api/deployment.tmpl.yaml > k8s/api/deployment.yaml

export ENVIRONMENT=$1
export DB_PASSWORD_BASE64=$(yq '.DB_PASSWORD' cicd/environments/$ENVIRONMENT.yaml)
envsubst < templates/db/postgres.tmpl.yaml > k8s/db/postgres.yaml


kubectl apply -f k8s --recursive
