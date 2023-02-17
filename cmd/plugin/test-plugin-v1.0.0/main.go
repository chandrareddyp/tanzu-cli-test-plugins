package main

import (
	"os"

	"github.com/aunum/log"

	"github.com/vmware-tanzu/tanzu-plugin-runtime/plugin"
)

var descriptor = plugin.PluginDescriptor{
	Name:        "test-plugin-v1.0.0",
	Description: "its a test plugin for the runtime library v1.0.0",
	Version:     "v1.0.0",
	BuildSHA:    "SHA100VER",
	Group:       plugin.ManageCmdGroup, // set group
}

func main() {
	p, err := plugin.NewPlugin(&descriptor)
	if err != nil {
		log.Fatal(err)
	}
	p.AddCommands(
		// Add commands
	)
	if err := p.Execute(); err != nil {
		os.Exit(1)
	}
}
