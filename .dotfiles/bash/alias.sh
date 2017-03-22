alias ansible-vault="docker run --rm -i \
    -v $(pwd):/src \
    --entrypoint ansible-vault \
    adlawson/ansible:2.0"

#alias mysql="docker run --rm -i \
    #-v $(echo ~)/.my.cnf:/etc/mysql/conf.d/my.cnf \
    #adlawson/mysql:5.7 mysql"

alias node="docker run --rm -it -v $(pwd):/src -w /src node"

alias npm="docker run --rm -it \
    -v $(pwd):/src \
    -v $(echo ~)/.npm:/root/.npm \
    -v $(echo ~)/.npmrc:/root/.npmrc \
    -w /src \
    node npm"

alias sbt="docker run --rm -it \
    -v $(echo ~)/.ivy2:/root/.ivy2 \
    -v $(pwd):/src \
    -e ARTIFACTORY_USER \
    -e ARTIFACTORY_PASS \
    --entrypoint sbt \
    adlawson/sbt:fakeroot"

alias scala="docker run --rm -it \
    -v $(pwd):/src \
    --entrypoint scala \
    adlawson/scala:2.12"

alias scalac="docker run --rm -it \
    -v $(pwd):/src \
    --entrypoint scalac \
    adlawson/scala:2.12"

alias vargant="vagrant"

alias vault="docker run --rm -it -p 8200:8200 vault"
