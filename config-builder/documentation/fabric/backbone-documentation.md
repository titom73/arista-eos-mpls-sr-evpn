# backbone

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [ISIS CLNS interfaces](#isis-clns-interfaces)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| backbone | p | s1-p01 | 192.168.2.111/24 | ceos | Provisioned | - |
| backbone | p | s1-p02 | 192.168.2.112/24 | ceos | Provisioned | - |
| backbone | pe | s1-pe01 | 192.168.2.11/24 | ceos | Provisioned | - |
| backbone | pe | s1-pe02 | 192.168.2.12/24 | ceos | Provisioned | - |
| backbone | pe | s1-pe03 | 192.168.2.13/24 | ceos | Provisioned | - |
| backbone | pe | s1-pe04 | 192.168.2.14/24 | ceos | Provisioned | - |
| backbone | p | s2-p01 | 192.168.2.121/24 | ceos | Provisioned | - |
| backbone | p | s2-p02 | 192.168.2.122/24 | ceos | Provisioned | - |
| backbone | pe | s2-pe01 | 192.168.2.21/24 | ceos | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| p | s1-p01 | Ethernet1 | pe | s1-pe01 | Ethernet1 |
| p | s1-p01 | Ethernet2 | pe | s1-pe02 | Ethernet1 |
| p | s1-p01 | Ethernet3 | pe | s1-pe03 | Ethernet1 |
| p | s1-p01 | Ethernet4 | pe | s1-pe04 | Ethernet1 |
| p | s1-p01 | Ethernet5 | p | s1-p02 | Ethernet5 |
| p | s1-p01 | Ethernet6 | p | s2-p01 | Ethernet6 |
| p | s1-p01 | Ethernet7 | p | s2-p02 | Ethernet7 |
| p | s1-p02 | Ethernet1 | pe | s1-pe01 | Ethernet2 |
| p | s1-p02 | Ethernet2 | pe | s1-pe02 | Ethernet2 |
| p | s1-p02 | Ethernet3 | pe | s1-pe03 | Ethernet2 |
| p | s1-p02 | Ethernet4 | pe | s1-pe04 | Ethernet2 |
| p | s1-p02 | Ethernet6 | p | s2-p02 | Ethernet6 |
| p | s2-p01 | Ethernet1 | pe | s2-pe01 | Ethernet1 |
| p | s2-p01 | Ethernet5 | p | s2-p02 | Ethernet5 |
| p | s2-p02 | Ethernet1 | pe | s2-pe01 | Ethernet2 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| s1-p01 | Ethernet1 | 10.255.3.1/31 | s1-pe01 | Ethernet1 | 10.255.3.0/31 |
| s1-p01 | Ethernet2 | 10.255.3.5/31 | s1-pe02 | Ethernet1 | 10.255.3.4/31 |
| s1-p01 | Ethernet3 | 10.255.3.9/31 | s1-pe03 | Ethernet1 | 10.255.3.8/31 |
| s1-p01 | Ethernet4 | 10.255.3.13/31 | s1-pe04 | Ethernet1 | 10.255.3.12/31 |
| s1-p01 | Ethernet5 | 10.255.3.24/31 | s1-p02 | Ethernet5 | 10.255.3.25/31 |
| s1-p01 | Ethernet6 | 10.255.3.20/31 | s2-p01 | Ethernet6 | 10.255.3.21/31 |
| s1-p01 | Ethernet7 | 10.255.3.28/31 | s2-p02 | Ethernet7 | 10.255.3.29/31 |
| s1-p02 | Ethernet1 | 10.255.3.3/31 | s1-pe01 | Ethernet2 | 10.255.3.2/31 |
| s1-p02 | Ethernet2 | 10.255.3.7/31 | s1-pe02 | Ethernet2 | 10.255.3.6/31 |
| s1-p02 | Ethernet3 | 10.255.3.11/31 | s1-pe03 | Ethernet2 | 10.255.3.10/31 |
| s1-p02 | Ethernet4 | 10.255.3.15/31 | s1-pe04 | Ethernet2 | 10.255.3.14/31 |
| s1-p02 | Ethernet6 | 10.255.3.22/31 | s2-p02 | Ethernet6 | 10.255.3.23/31 |
| s2-p01 | Ethernet1 | 10.255.3.17/31 | s2-pe01 | Ethernet1 | 10.255.3.16/31 |
| s2-p01 | Ethernet5 | 10.255.3.26/31 | s2-p02 | Ethernet5 | 10.255.3.27/31 |
| s2-p02 | Ethernet1 | 10.255.3.19/31 | s2-pe01 | Ethernet2 | 10.255.3.18/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 10.255.0.0/27 | 32 | 4 | 12.5 % |
| 10.255.1.0/27 | 32 | 5 | 15.63 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| backbone | s1-p01 | 10.255.0.1/32 |
| backbone | s1-p02 | 10.255.0.2/32 |
| backbone | s1-pe01 | 10.255.1.1/32 |
| backbone | s1-pe02 | 10.255.1.2/32 |
| backbone | s1-pe03 | 10.255.1.3/32 |
| backbone | s1-pe04 | 10.255.1.4/32 |
| backbone | s2-p01 | 10.255.0.3/32 |
| backbone | s2-p02 | 10.255.0.4/32 |
| backbone | s2-pe01 | 10.255.1.5/32 |

### ISIS CLNS interfaces

| POD | Node | CLNS Address |
| --- | ---- | ------------ |
| backbone | s1-p01 | 49.0001.0102.5500.0001.00 |
| backbone | s1-p02 | 49.0001.0102.5500.0002.00 |
| backbone | s1-pe01 | 49.0001.0102.5500.1001.00 |
| backbone | s1-pe02 | 49.0001.0102.5500.1002.00 |
| backbone | s1-pe03 | 49.0001.0102.5500.1003.00 |
| backbone | s1-pe04 | 49.0001.0102.5500.1004.00 |
| backbone | s2-p01 | 49.0001.0102.5500.0003.00 |
| backbone | s2-p02 | 49.0001.0102.5500.0004.00 |
| backbone | s2-pe01 | 49.0001.0102.5500.1005.00 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------------ | ------------------- | ------------------ | ------------------ |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
