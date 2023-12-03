# Topology information

## Core information:

- Management network: `192.168.2.0/24 eq 32`

- Underlay point to point:
  - P to P links: `10.0.0.0/24 eq 31`
  - PE to P on site 1: `10.0.1.0/24 eq 31`
  - PE to P on site 2: `10.0.2.0/24 eq 31`

- Loopback0 subnets:
  - IPv4: `1.0.0.0/24 eq 32`
  - ISIS: `49.0192.0168.0000.0{{ rid.split('.')[3] }}.00`

## Pre-configured services:

- VRF: __CLIENTS__
  - route-target: `1:1`
  - redistribute:
      - `connected`
      - `static`
  - Vlan SVI:
      - ID: `1810` / Subnet: `10.18.10.0/24`
  - Loopback:
    - ID: `1810` / Subnet: `1.18.10.0/24 eq 32`

### VLANS

- Vlan: `1810`
  - route-target: `1810:1810`
  - redistribute_routes:
      - `learned`
      - `router-mac system default-gateway`


## Ethernet Segments

- ESI: `0000:0000:0101:0101:0101`
  - Members:
    - `s1-pe01` - `eth4 / po4`
    - `s1-pe02` - `eth4 / po4`

- ESI: `0000:0000:0101:0101:0202`
  - Members:
    - `s2-pe01` - `eth4 / po4`
    - `s2-pe02` - `eth4 / po4`