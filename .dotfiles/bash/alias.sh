alias ansible-vault="docker run --rm -i \
    -v "$PWD":/src \
    adlawson/ansible-vault:2.0"

alias mysql="docker run --rm -i \
    -v $HOME/.my.cnf:/etc/mysql/conf.d/my.cnf \
    adlawson/mysql:5.7 mysql"

alias node="docker run --rm -it -v $PWD:/src -w /src node"

alias npm="docker run --rm -it -v $PWD:/src -w /src --entrypoint npm node"

alias sbt="docker run --rm -it \
    -v "$HOME/.ivy2":/root/.ivy2 \
    -v "$PWD":/src \
    -e ARTIFACTORY_USER \
    -e ARTIFACTORY_PASS \
    adlawson/sbt:fakeroot"

alias vargant="vagrant"

alias vault="docker run --rm -it vault"
