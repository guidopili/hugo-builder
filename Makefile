VERSION?=0.70.0
IMAGE_REPOSITORY?=guidopili/hugo-builder
IMAGE_TAG?=$(VERSION)

build:
	docker build --build-arg HUGO_VERSION=$(VERSION) -t $(IMAGE_REPOSITORY):$(IMAGE_TAG) .

push:
	docker push $(IMAGE_REPOSITORY):$(IMAGE_TAG)

tag-latest:
	docker tag $(IMAGE_REPOSITORY):$(IMAGE_TAG) $(IMAGE_REPOSITORY)

all: build push

.PHONY: build push tag-latest
