if [ -z "$1" ]; then
  echo "Please provide an argument with the registry username"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Please provide an argument with the registry password"
  exit 1
fi

if [ -z "$3" ]; then
  echo "Please provide an argument with the registry url"
  exit 1
fi

if [ -z "$4" ]; then
  echo "Please provide an argument with the registry image"
  exit 1
fi

# $5 which is tag can be empty

export CI_REGISTRY_USER=$1
export CI_REGISTRY_PASSWORD=$2
export CI_REGISTRY=$3
export CI_REGISTRY_IMAGE=$4
export tag=$5

DOCKER_DEFAULT_PLATFORM=linux/amd64 # this is needed for local build in macOs m1

docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
docker build --pull -t "$CI_REGISTRY_IMAGE${tag}" .
docker push "$CI_REGISTRY_IMAGE${tag}"
