module github.com/fluxcd/kustomize-controller

go 1.16

replace github.com/fluxcd/kustomize-controller/api => ./api

require (
	filippo.io/age v1.0.0-rc.3
	github.com/cyphar/filepath-securejoin v0.2.2
	github.com/drone/envsubst v1.0.3-0.20200804185402-58bc65f69603
	github.com/fluxcd/kustomize-controller/api v0.13.0
	github.com/fluxcd/pkg/apis/kustomize v0.2.0
	github.com/fluxcd/pkg/apis/meta v0.10.0
	github.com/fluxcd/pkg/runtime v0.12.0
	github.com/fluxcd/pkg/testserver v0.1.0
	github.com/fluxcd/pkg/untar v0.1.0
	github.com/fluxcd/source-controller/api v0.14.0
	github.com/go-logr/logr v0.4.0
	github.com/hashicorp/go-retryablehttp v0.6.8
	github.com/howeyc/gopass v0.0.0-20170109162249-bf9dde6d0d2c
	github.com/onsi/ginkgo v1.16.4
	github.com/onsi/gomega v1.13.0
	github.com/spf13/pflag v1.0.5
	go.mozilla.org/gopgagent v0.0.0-20170926210634-4d7ea76ff71a
	go.mozilla.org/sops/v3 v3.7.1
	golang.org/x/crypto v0.0.0-20210616213533-5ff15b29337e
	golang.org/x/net v0.0.0-20210428140749-89ef3d95e781
	google.golang.org/grpc v1.27.1
	k8s.io/api v0.21.1
	k8s.io/apiextensions-apiserver v0.21.1
	k8s.io/apimachinery v0.21.1
	k8s.io/client-go v0.21.1
	sigs.k8s.io/cli-utils v0.25.1-0.20210608181808-f3974341173a
	sigs.k8s.io/controller-runtime v0.9.0
	sigs.k8s.io/kustomize/api v0.8.10
	sigs.k8s.io/yaml v1.2.0
)

// pin kustomize to v4.1.3
replace (
	sigs.k8s.io/kustomize/api => github.com/sylr/kustomize/api v0.8.11-0.20210618083234-01294f4a90b5
	sigs.k8s.io/kustomize/kyaml => sigs.k8s.io/kustomize/kyaml v0.10.21
)
