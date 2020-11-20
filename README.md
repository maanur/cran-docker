# cran-docker
Docker-image for serving R packages sources, available in CRAN at image build time.
Useful in cases, when R build-server can't reach public CRAN mirrors because of some crooked enterprise security requirements.

## whish_list
Names of R packages to include in image.

## tekton
Tekton pipeline's objects definitions are packed with Helm.
To deploy CI/CD for this repository fork, first install helm (v3) and tekton (v0.14+ pipelines, v0.6+ triggers), then run:
```
helm install tekton ./tekton
```
