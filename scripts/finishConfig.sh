#!/bin/bash

cp -fr ./finish/module-config/* ./start/inventory
echo Now, you may run following commands to continue the tutorial:
echo cd start/inventory
echo ./gradlew libertyDev
