#!/bin/bash 

# set vars 
DOCKER_REPO="gcr.io/megangcp"
SKAFFOLD_FILE="./skaffold-release.yaml"


# get tag from env 
if [ -n "$1" ]; then
    TAG=$1 
else
    echo "Must provide a version tag."
    exit 
fi

# iterate over all services:
#  build + push image, inject tag into k8s manifest. 
for dir in ./src/*/    
do
    # docker build + push 
    svcname=$(basename $dir)
    image=$DOCKER_REPO/$svcname:$TAG
    echo "Building and pushing $svcname..." 
    docker build -t $image -f $dir/Dockerfile $dir 
    docker push $image 

    # inject new tag into the relevant k8s manifest
    pattern=".*image: $svcname:.*"
    replace="        image: $svcname:$TAG"
    manifestfile=./kubernetes-manifests/$svcname.yaml
    sed -i -e "s/$pattern/$replace/g" $manifestfile 
done
 

# create + push new release tag 
echo "Pushing git tag..."
git tag $TAG 
git push --tags

# push updated manifests to master 
echo "Commiting to master..."
git add .
git commit -m "Tagged release $TAG"
git push origin master

echo "✅ Successfully tagged release $TAG"
