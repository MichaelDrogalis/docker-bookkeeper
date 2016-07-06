## docker-bookkeeper

Docker image for Apache BookKeeper.

Uses the default `/ledgers` root in Zookeeper.

On startup this container will attempt to format Zookeeper (create `/ledgers` node)
if it's not already formatted. 