################################################################################
# start / stop / prepare
################################################################################

init:
	npm install

################################################################################
# releases
################################################################################

# patches a version
patch:
	npm run release:patch
	git push

# minor up
minor:
	npm run release:minor
	git push

# major up
release:
	npm run release
	git push

################################################################################
# docker building stuff
################################################################################
# you have to know what you're doing if your using this ;)

NODE_VERSION=14.4.0
DEBIAN_VERSION_NAME=buster
REGISTRY=talentplatforms/glyphhanger
VCS_URL=https://github.com/talentplatforms/glyphhanger

# DO NOT OVERRIDE!
_BUILD_DATE=$(shell echo $$(date -u +'%Y-%m-%dT%H:%M:%SZ'))
_VCS_REF=$(shell echo $$(git rev-parse --verify HEAD))
_IMAGE_LATEST=${REGISTRY}:latest
_DEBIAN_IMAGE_TAGGED=${REGISTRY}:${NODE_VERSION}-${DEBIAN_VERSION_NAME}-slim

# builds the image and tags it with the latest tag and the more specific tag defined in _IMAGE_TAGGED
build: build_alpine build_debian

build_debian:
	docker build \
	--rm \
	--build-arg NODE_VERSION=${NODE_VERSION} \
	--build-arg DEBIAN_VERSION_NAME=${DEBIAN_VERSION_NAME} \
	--build-arg BUILD_DATE=${_BUILD_DATE} \
	--build-arg VCS_URL=${VCS_URL} \
	--build-arg VCS_REF=${_VCS_REF} \
	--build-arg BUILDKIT_INLINE_CACHE=1 \
	-t ${_DEBIAN_IMAGE_TAGGED} \
	-f ./debian/Dockerfile \
	.

# pushes the tagged image to the registry
# if no variables are set, it uses the defaults
push: push_debian

push_debian:
	docker push ${_DEBIAN_IMAGE_TAGGED}

# make NODE_VERSION=13.10.1 build push
