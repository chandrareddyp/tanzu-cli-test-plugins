# tanzu-cli-test-plugins

Welcome, Its test plugin repository for end-to-end test cases
It has test plugins with different versions of Tanzu CLI Runtime Library https://github.com/vmware-tanzu/tanzu-plugin-runtime

## Install builder plugin

We need builder plugin to create new plugins, build plugins, generate artifacts and publish artifacts.
So run `make install-builder` which installs the builder plugin by downloading the builder plugin binary.

## Add new plugin

Add a plugin with the builder: `./bin/builder cli add-plugin myplugin`

## Directory Structure

artifacts/: Where you plugins build output will be located

cmd/plugin/<plugin>: Path where you plugins main directory will live

cmd/plugin/<plugin>/test: Plugins are required to have a test command defined

## How to update Tanzu Runtime Versions

Go to specific plugin under ./cmd/plugin/<plugin-name> then update the go.mod file with the tanzu runtime versions

## How to create and publish plugins

To create and publish plugins to your own repository, update the location PLUGIN_PUBLISH_REPOSITORY in plugin-tooling.mk file
then run `make plugin-build-and-publish-packages` to build and publish plugins
Run `make inventory-init` to initialize the plugin inventory database
Run `make inventory-plugin-insert` to update the plugins info in the inventory database

In your CLI you point the remote central repository URL (which is same as PLUGIN_PUBLISH_REPOSITORY) to search/discover the plugins
