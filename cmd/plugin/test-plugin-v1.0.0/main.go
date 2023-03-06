package main

import (
	"os"

	"github.com/aunum/log"
	"github.com/spf13/cobra"
	"github.com/vmware-tanzu/tanzu-plugin-runtime/component"
	"github.com/vmware-tanzu/tanzu-plugin-runtime/plugin"
	"github.com/vmware-tanzu/tanzu-plugin-runtime/plugin/buildinfo"
)

var descriptor = plugin.PluginDescriptor{
	Name:        "test-plugin-v1.0.0",
	Description: "its a test plugin for the runtime library v1.0.0",
	Version:     buildinfo.Version,
	BuildSHA:    "SHA100VER",
	Group:       plugin.ManageCmdGroup, // set group
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