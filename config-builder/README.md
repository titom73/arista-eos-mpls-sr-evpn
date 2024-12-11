# Topology information

## Core information

- Management network: `192.168.2.0/24 eq 32`
- Management gateway: `192.168.2.1`

- Underlay point to point: `10.255.3.0/24 eq 31`
- Loopback0 subnets:
  - IPv4:
    - P Nodes: `10.255.0.0/27 eq 32`
    - PE Nodes: `10.255.1.0/27 eq 32`
  - ISIS: `49.0001.0102.5500.1001.00`

## Pre-configured services

TBD

<!-- - VRF: __FW-HA__
  - Description: Firewall connectivity use case
  - route-target: `1:1`
  - redistribute:
      - `connected`
      - `static`
  - Vlan SVI:
      - ID: `1810` / Subnet: `10.18.10.0/24`
  - Loopback:
    - ID: `1810` / Subnet: `1.18.10.0/24 eq 32` -->

### VLANS

TBD

## Ethernet Segments

- ESI: `0000:0000:0101:0101:0101`
  - Members:
    - `s1-pe01` - `eth4 / po4`
    - `s1-pe02` - `eth4 / po4`
