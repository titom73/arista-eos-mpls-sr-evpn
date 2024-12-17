# L3VPN Use case

## Overview

This lab covers a L3VPN based on EVPN control-plane:

- Sub-interface to connect to `s1-ce03`
- Sub-interface to connect to `s1-ce04`
- `s1-ce03` and `s1-ce04` are both connected to the same network __`ASN 65101`__.
- `s2-ce01` is connected based on a SVI interface with BGP session.

![](./imgs/lab-topology-l3vpn.drawio.png)


## Technical details

### Connectivity

| CE node | CE interface   | IP address    | IP address    | PE interface   | PE node  |
|---------|----------------|---------------|---------------|----------------|----------|
|s1-ce03  | Ethernet2.1203 | `10.2.0.1/31` | `10.2.0.0/31` | Ethernet5.1203 | s1-pe03  |
|s1-ce04  | Ethernet2.1203 | `10.2.0.3/31` | `10.2.0.2/31` | Ethernet5.1203 | s1-pe04  |
|s2-ce01  | Vlan1205       | `10.2.1.21/24`| `10.2.1.1/24` | Vlan1205       | s2-pe01  |

### Routing Policy

| Community      |  Action                 |
|--------------  |-------------------------|
| `65000: 10110` | `local-preference 110`  |
| `65000: 10090` | `local-preference 90`   |

### Configuration information

- VRF ID: `12`
- Tenant supernet: `10.2.0.0/16`
- Announced prefix: `10.2.254.0/24`
    - route-map s1-ce03: `set community 65000:10090`
    - route-map s1-ce04: `set community 65000:10110`

## Snapshot

```bash
# ANTA to capture information
$ anta exec snapshot -o anta/l3vpn -c anta/snapshot-core-l3vpn.yml --tags core
```

## Lab Scenario

### Dual homed network with local-preference

Local Preference is updated with a route-map in at EVPN peers level according communities set on s1-ce*.

```eos
admin@s2-pe01# show bgp neighbors 10.255.0.1 evpn received-routes route-type ip-prefix 10.2.254.0/24

BGP routing table information for VRF default
Router identifier 10.255.1.5, local AS number 65000
BGP routing table entry for ip-prefix 10.2.254.0/24, Route Distinguisher: 10.255.1.3:12
 Paths: 1 available
  65101
    10.255.1.3 from 10.255.0.1 (10.255.0.1)
      Origin INCOMPLETE, metric -, localpref 90, weight 0, tag 0, valid, internal, best
      Originator: 10.255.1.3, Cluster list: 10.255.0.1
      Community: 65000:10090
      Extended Community: Route-Target-AS:12:12 TunnelEncap:tunnelTypeMpls
      MPLS label: 116385
BGP routing table entry for ip-prefix 10.2.254.0/24, Route Distinguisher: 10.255.1.4:12
 Paths: 1 available
  65101
    10.255.1.4 from 10.255.0.1 (10.255.0.1)
      Origin INCOMPLETE, metric -, localpref 110, weight 0, tag 0, valid, internal, best
      Originator: 10.255.1.4, Cluster list: 10.255.0.1
      Community: 65000:10110
      Extended Community: Route-Target-AS:12:12 TunnelEncap:tunnelTypeMpls
      MPLS label: 100001
```

### OSPF as CE to PE for site02

Export BGP to OSPF and mark type-5/external with [`dn-bits` / RFC4576](https://www.rfc-editor.org/rfc/rfc4576#section-4)

```eos
route-map RM-BGP-TO-OSPF permit 10
   description Redistribute BGP to OSPF
   match ip address prefix-list PL-ATM-FAKE-PREFIX
   set tag 1205
!
router ospf 1205 vrf ATM
   router-id 10.255.1.5
   passive-interface default
   no passive-interface Vlan1205
   redistribute bgp route-map RM-BGP-TO-OSPF
!
```

On s2-ce01:

```
router ospf 1205 vrf ATM
   no passive-interface Vlan1205
   dn-bit-ignore
!
```

And you can monitor LSDB state:

```eos
s2-ce01#show ip ospf database external vrf ATM

            OSPF Router with ID(10.2.1.21) (Instance ID 1205) (VRF ATM)


                 Type-5 AS External Link States

  LS Age: 393
  Options: (E DC DN)
  LS Type: AS External Links
  Link State ID: 10.2.254.0
  Advertising Router: 10.255.1.5
  LS Seq Number: 0x80000002
  Checksum: 0x7ddd
  Length: 36
  Network Mask: 255.255.255.0
        Metric Type: 2
        Metric: 1
        Forwarding Address: 0.0.0.0
        External Route Tag: 1205

s2-ce01#show ip route vrf ATM

VRF: ATM
Source Codes:
       C - connected, S - static, K - kernel,
       O - OSPF, IA - OSPF inter area, E1 - OSPF external type 1,
       E2 - OSPF external type 2, N1 - OSPF NSSA external type 1,
       N2 - OSPF NSSA external type2, B - Other BGP Routes,
       B I - iBGP, B E - eBGP, R - RIP, I L1 - IS-IS level 1,
       I L2 - IS-IS level 2, O3 - OSPFv3, A B - BGP Aggregate,
       A O - OSPF Summary, NG - Nexthop Group Static Route,
       V - VXLAN Control Service, M - Martian,
       DH - DHCP client installed default route,
       DP - Dynamic Policy Route, L - VRF Leaked,
       G  - gRIBI, RC - Route Cache Route,
       CL - CBF Leaked Route

Gateway of last resort is not set

 C        10.2.1.0/24
           directly connected, Vlan1205
 O E2     10.2.254.0/24 [110/1]
           via 10.2.1.1, Vlan1205
```