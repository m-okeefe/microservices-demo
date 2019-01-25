# Deploying on a Istio-installed GKE cluster

# Step 1 (Option 1) - Create a New GKE Cluster 

1. Navigate to the Google Cloud Platform [Console](https://console.cloud.google.com). 
1. [Create a new GCP project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) (or use an existing project). 
1. Open Cloud Shell by clicking on the terminal icon in the top-right sidebar.
1. Create a new GKE cluster: 


## Step 1 (Option 2) - Use an Existing GKE Cluster 
2. Use [Istio on GKE add-on](https://cloud.google.com/istio/docs/istio-on-gke/installing)
   to install Istio to your existing GKE cluster.

       gcloud beta container clusters update demo \
           --zone=us-central1-a \
           --update-addons=Istio=ENABLED \
           --istio-config=auth=MTLS_PERMISSIVE

   > NOTE: If you need to enable `MTLS_STRICT` mode, you will need to update
   > several manifest files:
   >
   > - `kubernetes-manifests/frontend.yaml`: delete "livenessProbe" and
   >   "readinessProbe" fields.
   > - `kubernetes-manifests/loadgenerator.yaml`: delete "initContainers" field.

3. (Optional) Enable Stackdriver Tracing/Logging with Istio Stackdriver Adapter
   by [following this guide](https://cloud.google.com/istio/docs/istio-on-gke/installing#enabling_tracing_and_logging).

4. Install the automatic sidecar injection (annotate the `default` namespace
   with the label):

       kubectl label namespace default istio-injection=enabled


## Step 2 - Deploy Resources  

5. Apply the manifests in [`./istio-manifests`](./istio-manifests) directory.

       kubectl apply -f ./istio-manifests

    This is required only once.

6. Deploy the application with `skaffold run --default-repo=gcr.io/[PROJECT_ID]`.

7. Run `kubectl get pods` to see pods are in a healthy and ready state.

8. Find the IP address of your istio gateway Ingress or Service, and visit the
   application.

       INGRESS_HOST="$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"

       echo "$INGRESS_HOST"

       curl -v "http://$INGRESS_HOST"