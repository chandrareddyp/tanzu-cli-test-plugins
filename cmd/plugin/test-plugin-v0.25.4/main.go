package main

import (
	"os"

	"github.com/aunum/log"
	cliv1alpha1 "github.com/vmware-tanzu/tanzu-framework/apis/cli/v1alpha1"
	plugin "github.com/vmware-tanzu/tanzu-framework/pkg/v1/cli/command/plugin"
)

var descriptor = cliv1alpha1.PluginDescriptor{
	Name:        "test-plugin-v0.25.4",
	Description: "its a test plugin for the runtime library v0.25.4",
	Version:     "v0.25.4",
	BuildSHA:    "SHA0254VER",
	Group:       cliv1alpha1.ManageCmdGroup, // set group
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
