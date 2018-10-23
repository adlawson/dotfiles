alias aws='docker run --rm -it -v $PWD:/src -v $HOME/.aws:/root/.aws -w /src -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION mesosphere/aws-cli'

alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

alias keytool='docker run --rm -it -v $PWD:/src -w /src --entrypoint keytool openjdk'

alias sbt='docker run --rm -it -v $HOME/.ivy2:/root/.ivy2 -v $PWD:/src -v /var/run/docker.sock:/var/run/docker.sock -p 3000:3000 -e ARTIFACTORY_USER -e ARTIFACTORY_PASS --entrypoint sbt adlawson/sbt'

alias scala='docker run --rm -it -v $PWD:/src --entrypoint scala adlawson/scala'

alias terraform='docker run --rm -it -v $HOME/.aws:/root/.aws -p 8500:8500 -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION hashicorp/terraform:light'

alias vault='docker run --rm -it -p 8200:8200 -e VAULT_ADDR -e VAULT_TOKEN vault'
