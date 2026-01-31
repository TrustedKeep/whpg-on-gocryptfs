# Deploy WarehousePG 7.x on EC2

This repository contains a playbook and two related roles to provision EC2 instances and configure [WarehousePG](https://github.com/warehouse-pg/warehouse-pg). The configuration role (`gp_install`) will create files and scripts to provision a cluster with three segments per node, but stops short of actually creating the cluster. However, it installs a script with the appropriate `gpinitsystem` command.

## Build WarehousePG

Run the following to build WarehousePG and create a tar.gz file of the resulting binaries:

```shell
./build/build.sh
```

## Running

Copy the sample vars.yaml and customize `vars.yaml`:

```shell
cp ./vars/vars.yaml.sample ./vars/vars.yaml
```

Run the playbook:

```shell
ansible-playbook site.yaml
```

When the play is complete, ssh to the coordinator and run `/gp/build_cluster` to run `gpinitsystem`.

You can test host equivalency via:

```shell
gpssh -f /gp/hostfile df -hT -t xfs -t fuse.gocryptfs
```

## Configuration

Most of the cluster settings (e.g. segments per node) are hard-coded in the `gp_install` role's `templates`. See `clusterConfigFile.j2` for more information.

## Testing

There's two scripts under `/gp` on the instances that will run some tests:

1. `run-sql-test` will use pgbench to generate a load
2. `run-sql-test` will use psql to create various tables with various storage options. It accepts an optional single positional argument with the number of rows to load into each table. The default is 10,000.

## TODO

- `provision` role only enforces present/running. Removal/termination is currently manual.
