package main

import (
	"os"

	"github.com/aunum/log"
	"github.com/spf13/cobra"
	cliapi "github.com/vmware-tanzu/tanzu-framework/cli/runtime/apis/cli/v1alpha1"
	"github.com/vmware-tanzu/tanzu-framework/cli/runtime/buildinfo"
	"github.com/vmware-tanzu/tanzu-framework/cli/runtime/component"
	plugin "github.com/vmware-tanzu/tanzu-framework/cli/runtime/plugin"
)

var descriptor = cliapi.PluginDescriptor{
	Name:        "test-plugin-v0.28.0",
	Description: "its a test plugin for the runtime library v0.28.0",
	Version:     buildinfo.Version,
	BuildSHA:    "SHA02800VER",
	Group:       cliapi.ManageCmdGroup, // set group
}

var outputFormat string

func main() {
	p, err := plugin.NewPlugin(&descriptor)
	if err != nil {
		log.Fatal(err)
	}
	helloCmd := newHelloWorldCmd()
	helloCmd.Flags().StringVarP(&outputFormat, "output", "o", "", "Output format (yaml|json|table)")
	p.AddCommands(
		helloCmd,
	)
	if err := p.Execute(); err != nil {
		os.Exit(1)
	}
}

func newHelloWorldCmd() *cobra.Command{
	return &cobra.Command{
		Use: "hello-world",
		Short: "Its a test command to test plugin command",
		Run: func(cmd *cobra.Command, args []string){
			output := component.NewOutputWriter(cmd.OutOrStdout(), outputFormat, "message")
			output.AddRow("the command hello-world executed successfully")
			output.Render()
			},
	}
}