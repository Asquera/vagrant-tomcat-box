#!/bin/env bash

## java ##
alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 20000
## javaws ##
alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 20000
 
## Java Browser (Mozilla) Plugin 32-bit ##
#alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/latest/jre/lib/i386/libnpjp2.so 20000
 
## Java Browser (Mozilla) Plugin 64-bit ##
#alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so 20000
 
## Install javac only if you installed JDK (Java Development Kit) package ##
alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 20000
alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 20000

