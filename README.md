## docker-bookkeeper

Docker image for Apache BookKeeper.

Uses the default `/ledgers` root in Zookeeper.

## Usage

Set the environment variable to point at Zookeeper.
`ZOOKEEPER_ADDR=<zookeeper_address:port>`

If this is your first start, make sure to call the container with the
command `shell metaformat -nonInteractive`. This will create the necessary
Zookeeper structure.

## Kubernetes Use

Just `kubectl create -f bookkeeper.petset.yaml`. This will ensure
`shell metaformat -nonInteractive` is run as an init step.