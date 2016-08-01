## docker-bookkeeper

Docker image for Apache BookKeeper.

Uses the default `/ledgers` root in Zookeeper.
The only change from a default Bookkeeper configuration is prefering to
use the containers hostname over it's IP address. This is because Kubernetes
PetSet abstraction guarantees a stable hostname between crashes.

## Usage

Set the environment variable to point at Zookeeper.
`ZOOKEEPER_ADDR=<zookeeper_address:port>`

If this is your first start, make sure to call the container with the
command `shell metaformat -nonInteractive`. This will create the necessary
Zookeeper structure.

## Kubernetes Use

Just `kubectl create -f bookkeeper.petset.yaml`. This will ensure
`shell metaformat -nonInteractive` is run as an init step.

## Note on Volume Provisioners
If you don't have a dynamic volume provisioner running on your Kubernetes cluster, you must remove this annotation and
supply your own persistent volumes.

```
        annotations:
          volume.alpha.kubernetes.io/storage-class: anything
```
