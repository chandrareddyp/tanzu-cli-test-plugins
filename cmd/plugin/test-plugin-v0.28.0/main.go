package main

import (
	"os"

	"github.com/aunum/log"
	cliapi "github.com/vmware-tanzu/tanzu-framework/cli/runtime/apis/cli/v1alpha1"
	"github.com/vmware-tanzu/tanzu-framework/cli/runtime/buildinfo"
	plugin "github.com/vmware-tanzu/tanzu-framework/cli/runtime/plugin"
)

var descriptor = cliapi.PluginDescriptor{
	Name:        "test-plugin-v0.28.0",
	Description: "its a test plugin for the runtime library v0.28.0",
	Version:     buildinfo.Version,
	BuildSHA:    "SHA02800VER",
	Group:       cliapi.ManageCmdGroup, // set group
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
