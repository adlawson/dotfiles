alias ansible-vault='docker run --rm -i -v $PWD:/src -v $HOME/.ansiblevault:/root/.ansiblevault --entrypoint ansible-vault adlawson/ansible:2.0'

alias aws='docker run --rm -it -v $PWD:/src -w /src -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION mesosphere/aws-cli'

alias keytool='docker run --rm -it -v $PWD:/src -w /src --entrypoint keytool openjdk'

alias node='docker run --rm -it -v $PWD:/src -w /src node'

alias npm='docker run --rm -it -v $PWD:/src -v $HOME/.npm:/root/.npm -v $HOME/.npmrc:/root/.npmrc -w /src node npm'

alias sbt='docker run --rm -it -v $HOME/.ivy2:/root/.ivy2 -v $PWD:/src -v /var/run/docker.sock:/var/run/docker.sock -e ARTIFACTORY_USER -e ARTIFACTORY_PASS --entrypoint sbt adlawson/sbt'

alias scala='docker run --rm -it -v $PWD:/src --entrypoint scala adlawson/scala'

alias scalac='docker run --rm -it -v $PWD:/src --entrypoint scalac adlawson/scala'

alias travis='docker run --rm -it -v $HOME/.travis:/root/.travis -v $PWD:/src adlawson/travis'

alias vault='docker run --rm -it -p 8200:8200 vault'
