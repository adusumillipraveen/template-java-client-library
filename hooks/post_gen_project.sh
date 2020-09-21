#!/bin/bash

cat publish.gradle >> build.gradle
rm -rf pom.xml .gradle publish.gradle
