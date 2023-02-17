package main

import (
	"os"

	"github.com/aunum/log"
	plugin "github.com/vmware-tanzu/tanzu-framework/pkg/v1/cli/command/plugin"
)

var descriptor = plugin.PluginDescriptor{
	Name:        "test-plugin-v0.11.6",
	Description: "its a test plugin for the runtime library v0.11.6",
	Version:     "v0.11.6",
	BuildSHA:    "aser8",
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
