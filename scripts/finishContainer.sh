#!/bin/bash

if [[ -e ./start/inventory ]]; then
    rm -fr ./start/inventory
fi
mkdir ./start/inventory
cp -fr ./finish/module-starter/* ./start/inventory
cp -fr ./finish/module-jwt/* ./start/inventory
mkdir -p ./start/inventory/src/main/liberty/config/resources/security
cp ./finish/system/src/main/liberty/config/resources/security/key.p12 ./start/inventory/src/main/liberty/config/resources/security/key.p12
mkdir ./start/inventory/src/main/java/io/openliberty/deepdive/rest/health
cp ./finish/module-health-checks/src/main/java/io/openliberty/deepdive/rest/health/*.java ./start/inventory/src/main/java/io/openliberty/deepdive/rest/health
cp ./finish/module-metrics/src/main/liberty/config/server.xml ./start/inventory/src/main/liberty/config
cp ./finish/module-metrics/src/main/java/io/openliberty/deepdive/rest/SystemResource.java ./start/inventory/src/main/java/io/openliberty/deepdive/rest
cp ./finish/module-kubernetes/Containerfile ./start/inventory

cd ./start/inventory || exit
./gradlew clean war libertyCreate installFeature deploy
podman build -t liberty-deepdive-inventory:1.0-SNAPSHOT .
cd ../../

./scripts/stopSystem.sh

echo Now, you completed the containerize section.
