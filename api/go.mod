module github.com/fluxcd/kustomize-controller/api

go 1.16

require (
	github.com/fluxcd/pkg/apis/kustomize v0.2.0
	github.com/fluxcd/pkg/apis/meta v0.10.0
	github.com/fluxcd/pkg/runtime v0.12.0
	k8s.io/apiextensions-apiserver v0.21.1
	k8s.io/apimachinery v0.21.1
	sigs.k8s.io/controller-runtime v0.9.0
)
