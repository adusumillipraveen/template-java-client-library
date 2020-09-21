#!/bin/bash

docker run --rm -v "${PWD}:/{{cookiecutter.component_id}}" openapitools/openapi-generator-cli:v4.3.1 generate \
-i {{cookiecutter.swagger_path}} \
--api-package {{cookiecutter.api_package}} \
--model-package {{cookiecutter.model_package}} \
--invoker-package {{cookiecutter.invoker_package}} \
--group-id {{cookiecutter.group_id}} \
--artifact-id {{cookiecutter.component_id}} \
--artifact-version {{cookiecutter.artifact_version}} \
-g spring -p java8=true --library spring-cloud \
-o {{cookiecutter.component_id}}