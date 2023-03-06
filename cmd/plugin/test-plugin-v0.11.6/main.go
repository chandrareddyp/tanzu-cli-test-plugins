package main

import (
	"os"

	"github.com/aunum/log"
	"github.com/spf13/cobra"
	cliv1alpha1 "github.com/vmware-tanzu/tanzu-framework/apis/cli/v1alpha1"
	"github.com/vmware-tanzu/tanzu-framework/pkg/v1/buildinfo"
	plugin "github.com/vmware-tanzu/tanzu-framework/pkg/v1/cli/command/plugin"
	"github.com/vmware-tanzu/tanzu-framework/pkg/v1/cli/component"
)

var descriptor = cliv1alpha1.PluginDescriptor{
	Name:        "test-plugin-v0.11.6",
	Description: "its a test plugin for the runtime library v0.11.6",
	Version:     buildinfo.Version,
	BuildSHA:    "SHA0116VER",
	Group:       cliv1alpha1.ManageCmdGroup, // set group
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