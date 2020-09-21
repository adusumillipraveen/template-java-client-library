#!/bin/bash

#Generate client using openapi generator
docker run --rm -v "${PWD}:/{{cookiecutter.component_id}}" openapitools/openapi-generator-cli:v4.3.1 generate \
-i {{cookiecutter.swagger_path}} \
--api-package {{cookiecutter.api_package}} \
--model-package {{cookiecutter.model_package}} \
--invoker-package {{cookiecutter.invoker_package}} \
--group-id {{cookiecutter.group_id}} \
--artifact-id {{cookiecutter.component_id}} \
--artifact-version {{cookiecutter.artifact_version}} \
-g spring --library spring-cloud \
-o {{cookiecutter.component_id}}

#Hack to fix https error for mvn repo
REPOSITORIES="<repositories><repository><id>central</id><name>Central Repository</name><url>https://repo.maven.apache.org/maven2</url><layout>default</layout></repository></repositories>"
REPOS=$(echo $REPOSITORIES| sed 's/\//\\\//g')
sed  -i '' "s/<\/project>/ ${REPOS}<\/project>/" pom.xml

# convert mvn to gradle repo
docker run --rm -v "${PWD}:/{{cookiecutter.component_id}}" -w /{{cookiecutter.component_id}} gradle:6.6 gradle init --type pom --dsl groovy