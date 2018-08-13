
.PHONY: all
all: .built.docker requirements.txt

requirements.txt: requirements.in
	$(MAKE) requirements

.PHONY: requirements
requirements:
	docker run --rm -it -v "$(CURDIR):/src" pip-tools

.built.docker: Dockerfile requirements.txt
	$(MAKE) build
	touch .built.docker

.PHONY: build
build:
	docker build --rm -t bhomnick/pip-tools --build-arg SSH_KEY="$$(cat ../nm_dev)" .
