module github.com/chandrareddyp/tanzu-cli-test-plugins/test-plugin-v0.11.6

go 1.16

replace (
	sigs.k8s.io/cluster-api => sigs.k8s.io/cluster-api v1.0.1
	sigs.k8s.io/kind => sigs.k8s.io/kind v0.11.1
)

require (
	github.com/AlecAivazis/survey/v2 v2.3.6 // indirect
	github.com/aunum/log v0.0.0-20200821225356-38d2e2c8b489
	github.com/briandowns/spinner v1.19.0 // indirect
	github.com/fsnotify/fsnotify v1.5.4 // indirect
	github.com/olekukonko/tablewriter v0.0.5 // indirect
	github.com/onsi/ginkgo/v2 v2.1.6 // indirect
	github.com/spf13/cobra v1.6.1 // indirect
	github.com/stretchr/testify v1.8.1 // indirect
	github.com/tj/assert v0.0.3 // indirect
	github.com/vmware-tanzu/tanzu-framework v0.11.6
	go.uber.org/multierr v1.8.0 // indirect
	golang.org/x/mod v0.6.0 // indirect
)
