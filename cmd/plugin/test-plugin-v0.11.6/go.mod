module github.com/chandrareddyp/tanzu-cli-test-plugins/test-plugin-v0.11.6

go 1.16

replace (
	github.com/briandowns/spinner => github.com/alonyb/spinner v1.12.7
	github.com/googleapis/gnostic => github.com/googleapis/gnostic v0.5.5 // indirect
	github.com/k14s/kbld => github.com/anujc25/carvel-kbld v0.31.0-update-vendir
	sigs.k8s.io/cluster-api => sigs.k8s.io/cluster-api v1.0.1
	sigs.k8s.io/kind => sigs.k8s.io/kind v0.11.1
)

require (
	github.com/aunum/log v0.0.0-20200821225356-38d2e2c8b489
	github.com/spf13/cobra v1.6.1
	github.com/vmware-tanzu/tanzu-framework v0.11.6
)
