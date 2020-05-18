VERSION?=0.70.0
IMAGE_TAG?=guidopili/hugo-builder

build:
	docker build --build-arg HUGO_VERSION=$(VERSION) -t $(IMAGE_TAG) .

.PHONY: build
