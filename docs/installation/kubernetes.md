# Running Hipstershop on Kubernetes 

## Option 1: Google Kubernetes Engine (GKE)

1. Navigate to the Google Cloud Platform [Console](https://console.cloud.google.com). 
1. [Create a new GCP project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) (or use an existing project). 
1. Open Cloud Shell by clicking on the terminal icon in the top-right sidebar.
1. Create a new GKE cluster: 
1. Clone this repository.
1. Deploy the application: `kubectl apply -f ./release/kubernetes-manifests`  
1. Run `kubectl get pods` to see pods are in a healthy and ready state.
1.  Find the IP address of your application, then visit the application on your
    browser to confirm installation.

        kubectl get service frontend-external


## Option 2: Other Kubernetes Distributions 

**Prerequisite**: a running Kubernetes cluster. You can set up a local, single-node cluster using
[Minikube](https://github.com/kubernetes/minikube).

1. Clone this repository.
1. Deploy the application: `kubectl apply -f ./release/kubernetes-manifests`  
1. Run `kubectl get pods` to see pods are in a healthy and ready state.
1.  Find the IP address of your application, then visit the application on your
    browser to confirm installation.

        kubectl get service frontend-external
