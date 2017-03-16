alias vargant="vagrant"

alias sbt="docker run --rm -it \
    -v "$HOME/.ivy2":/root/.ivy2 \
    -v `pwd`:/src \
    -e ARTIFACTORY_USER \
    -e ARTIFACTORY_PASS \
    adlawson/sbt:fakeroot"
