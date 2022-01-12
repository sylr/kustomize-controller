ARG GO_VERSION=1.17
ARG XX_VERSION=1.1.0

FROM --platform=$BUILDPLATFORM tonistiigi/xx:${XX_VERSION} AS xx

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine as gomod

# Copy the build utilities.
COPY --from=xx / /

ARG TARGETPLATFORM

WORKDIR /workspace

# copy go modules manifests
COPY ./api/go.mod ./api/go.sum ./api/
COPY go.mod go.sum ./

# download dependencies
RUN go mod download

# ------------------------------------------------------------------------------
# go crossbuild stage

FROM --platform=$BUILDPLATFORM golang:1.17-alpine as builder

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

WORKDIR /workspace

COPY --from=gomod /go/pkg/ /go/pkg/

# copy sources
COPY . .

# Switch shell to bash
RUN apk add --no-cache bash
SHELL ["bash", "-c"]

# build
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} GOARM=${TARGETVARIANT/v/} \
go build -a -trimpath -o kustomize-controller main.go

# ------------------------------------------------------------------------------
# Final images build stage

FROM --platform=$TARGETPLATFORM alpine:3.15

ARG TARGETPLATFORM

LABEL org.opencontainers.image.source="https://github.com/fluxcd/kustomize-controller"

RUN apk add --no-cache ca-certificates curl tini git openssh-client gnupg

RUN kubectl_ver=1.21.3 && \
arch=${TARGETPLATFORM:-linux/amd64} && \
if [ "$TARGETPLATFORM" == "linux/arm/v7" ]; then arch="linux/arm"; fi && \
curl -sL https://storage.googleapis.com/kubernetes-release/release/v${kubectl_ver}/bin/${arch}/kubectl \
-o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

RUN kubectl version --client=true

COPY --from=builder /workspace/kustomize-controller /usr/local/bin/

# Create minimal nsswitch.conf file to prioritize the usage of /etc/hosts over DNS queries.
# https://github.com/gliderlabs/docker-alpine/issues/367#issuecomment-354316460
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

RUN addgroup -S controller && adduser -S controller -G controller

USER controller

ENV GNUPGHOME=/tmp

ENTRYPOINT [ "/sbin/tini", "--", "kustomize-controller" ]
