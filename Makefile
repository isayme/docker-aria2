VERSION := 0.1.0

.PHONY: image
image:
	docker build -t aria2:${VERSION} .

.PHONY: publish
publish: image
	docker tag aria2:${VERSION} isayme/aria2:${VERSION}
	docker push isayme/aria2:${VERSION}
