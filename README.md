vagrant-tomcat-box
==================

A vagrant box to develop in jruby/tomcat.

## Java-Installation

Since oracle requires to accept the java TOS, you need to download the jre from
http://www.oracle.com/technetwork/java/javase/downloads/index.html  and place it in
`modules/java/files/rpms`.

## Installing a Database

The box contains recipes for pg, oracle and redis. To control which software is installed
on the adapt the `tomcat-server.pp` manifest to include the appropriate classes.

### Oracle

To use the oracle recipe you need to download the oracle-xe rpm and drop it in modules/oracle-xe/files/rpms.

## Box-Setup

The box is set to accept GIT_* variables over SSH, so that you can export your local
git env into the box.

The box uses and requires the vagrant-dns plugin.
