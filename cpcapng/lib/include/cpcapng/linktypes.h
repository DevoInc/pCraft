#ifndef _CPCAPNG_LINKTYPES_H_
#define _CPCAPNG_LINKTYPES_H_

/* Generated from https://github.com/pcapng/pcapng/blob/master/linktypes.txt 
 * Using emacs macro magic
 */

/* BSD loopback encapsulation */
#define LINKTYPE_NULL 0
/* IEEE 802.3 Ethernet */
#define LINKTYPE_ETHERNET 1
/* AX.25 packet */
#define LINKTYPE_AX25 3
/* IEEE 802.5 Token Ring */
#define LINKTYPE_IEEE802_5 6
/* ARCNET Data Packets */
#define LINKTYPE_ARCNET_BSD 7
/* SLIP, w/LINKTYPE_SLIP header. */
#define LINKTYPE_SLIP 8
/* PPP, as per RFC 1661/RFC 1662 */
#define LINKTYPE_PPP 9
/* FDDI: per ANSI INCITS 239-1994. */
#define LINKTYPE_FDDI 10
/* PPP in HDLC-like framing, as per RFC 1662 */
#define LINKTYPE_PPP_HDLC 50
/* PPPoE; per RFC 2516 */
#define LINKTYPE_PPP_ETHER 51
/* RFC 1483 LLC/SNAP-encapsulated ATM */
#define LINKTYPE_ATM_RFC1483 100
/* Raw IP; begins with an IPv4 or IPv6 header */
#define LINKTYPE_RAW 101
/* Cisco PPP with HDLC framing, as per section 4.3.1 of RFC 1547 */
#define LINKTYPE_C_HDLC 104
/* IEEE 802.11 wireless LAN. */
#define LINKTYPE_IEEE802_11 105
/* Frame Relay LAPF frames */
#define LINKTYPE_FRELAY 107
/* OpenBSD loopback encapsulation */
#define LINKTYPE_LOOP 108
/* Linux "cooked" capture encapsulation */
#define LINKTYPE_LINUX_SLL 113
/* Apple LocalTalk */
#define LINKTYPE_LTALK 114
/* OpenBSD pflog; "struct pfloghdr" structure */
#define LINKTYPE_PFLOG 117
/* Prism monitor mode */
#define LINKTYPE_IEEE802_11_PRISM 119
/* RFC 2625 IP-over-Fibre Channel */
#define LINKTYPE_IP_OVER_FC 122
/* ATM traffic, / per SunATM devices */
#define LINKTYPE_SUNATM 123
/* Radiotap - followed by an 802.11 header */
#define LINKTYPE_IEEE802_11_RADIOTAP 127
/* ARCNET Data Packets, per RFC 1051 frames w/variations */
#define LINKTYPE_ARCNET_LINUX 129
/* Apple IP-over-IEEE 1394 cooked header */
#define LINKTYPE_APPLE_IP_OVER_IEEE1394 138
/* Signaling System 7 (SS7) Message Transfer Part Level ITU-T Q.703 */
#define LINKTYPE_MTP2_WITH_PHDR 139
/* SS7 Level 2, Q.703 */
#define LINKTYPE_MTP2 140
/* SS7 Level 3, Q.704 */
#define LINKTYPE_MTP3 141
/* SS7 Control Part, ITU-T Q.711/Q.712/Q.713/Q.714 */
#define LINKTYPE_SCCP 142
/* DOCSIS MAC frames, DOCSIS 3.1 */
#define LINKTYPE_DOCSIS 143
/* Linux-IrDA packets w/LINKTYPE_LINUX_IRDA header */
#define LINKTYPE_LINUX_IRDA 144
/* AVS monitor mode w/802.11 header */
#define LINKTYPE_IEEE802_11_AVS 163
/* BACnet MS/TP frames, per 9.3 MS/TP Frame Format ANSI 135 */
#define LINKTYPE_BACNET_MS_TP 165
/* PPP in HDLC-like encapsulation, like LINKTYPE_PPP_HDLC, different stuffing */
#define LINKTYPE_PPP_PPPD 166
/* General Packet Radio Service Logical Link Control, as per 3GPP TS 04.64 */
#define LINKTYPE_GPRS_LLC 169
/* Transparent-mapped generic framing procedure, as specified by ITU-T Recommendation G.7041/Y.1303 */
#define LINKTYPE_GPF_T 170
/* Frame-mapped generic framing procedure, as specified by ITU-T Recommendation G.7041/Y.1303 */
#define LINKTYPE_GPF_F 171
/* Link Access Procedures on the D Channel (LAPD) frames, as specified by ITU-T Recommendation Q.920 and ITU-T Recommendation Q.921 , captured via vISDN, with a LINKTYPE_LINUX_LAPD header , followed by the Q.921 frame, starting with the address field. */
#define LINKTYPE_LINUX_LAPD 177
/* FRF.16.1 Multi-Link Frame Relay frames, beginning with an FRF.12 Interface fragmentation format fragmentation header. */
#define LINKTYPE_MFR 182
/* Bluetooth HCI UART transport layer; the frame contains an HCI packet indicator byte, as specified by the UART Transport Layer portion of the most recent Bluetooth Core specification , followed by an HCI packet of the specified packet type, as specified by the Host Controller Interface Functional Specification portion of the most recent Bluetooth Core Specification. */
#define LINKTYPE_BLUETOOTH_HCI_H4 187
/* USB packets, beginning with a Linux USB header, as specified by the struct usbmon_packet in the Documentation/usb/usbmon.txt file in the Linux source tree. Only the first 48 bytes of that header are present. All fields in the header are in host byte order. When performing a live capture, the host byte order is the byte order of the machine on which the packets are captured. When reading a pcap file, the byte order is the byte order for the file, as specified by the file's magic number; when reading a pcapng file, the byte order is the byte order for the section of the pcapng file, as specified by the Section Header Block. */
#define LINKTYPE_USB_LINUX 189
/* Per-Packet Information information, as specified by the Per-Packet Information Header Specification , followed by a packet with the LINKTYPE_ value specified by the pph_dlt field of that header. */
#define LINKTYPE_PPI 192
/* IEEE 802.15.4 Low-Rate Wireless Networks, with each packet having the FCS at the end of the frame. */
#define LINKTYPE_IEEE802_15_4_WITHFCS 195
/* Various link-layer types, with a pseudo-header , for SITA */
#define LINKTYPE_SITA 196
/* Various link-layer types, with a pseudo-header, for Endace DAG cards; encapsulates Endace ERF records. */
#define LINKTYPE_ERF 197
/* Bluetooth HCI UART transport layer; the frame contains a 4-byte direction field, in network byte order (big-endian), the low-order bit of which is set if the frame was sent from the host to the controller and clear if the frame was received by the host from the controller, followed by an HCI packet indicator byte, as specified by the UART Transport Layer portion of the most recent Bluetooth Core specification , followed by an HCI packet of the specified packet type, as specified by the Host Controller Interface Functional Specification portion of the most recent Bluetooth Core Specification. */
#define LINKTYPE_BLUETOOTH_HCI_H4_WITH_PHDR 201
/* AX.25 packet, with a 1-byte KISS header containing a type indicator. */
#define LINKTYPE_AX25_KISS 202
/* Link Access Procedures on the D Channel (LAPD) frames, as specified by ITU-T Recommendation Q.920 and ITU-T Recommendation Q.921 , starting with the address field, with no pseudo-header. */
#define LINKTYPE_LAPD 203
/* PPP, as per RFC 1661 and RFC 1662 , preceded with a one-byte pseudo-header with a zero value meaning received by this host and a non-zero value meaning sent by this host; if the first 2 bytes are 0xff and 0x03, it's PPP in HDLC-like framing, with the PPP header following those two bytes, otherwise it's PPP without framing, and the packet begins with the PPP header. The data in the frame is not octet-stuffed or bit-stuffed. */
#define LINKTYPE_PPP_WITH_DIR 204
/* Cisco PPP with HDLC framing, as per section 4.3.1 of RFC 1547 , preceded with a one-byte pseudo-header with a zero value meaning received by this host and a non-zero value meaning sent by this host. */
#define LINKTYPE_C_HDLC_WITH_DIR 205
/* Frame Relay LAPF frames, beginning with a one-byte pseudo-header with a zero value meaning received by this host (DCE->DTE) and a non-zero value meaning sent by this host (DTE->DCE), followed by an ITU-T Recommendation Q.922 LAPF header starting with the address field, and without an FCS at the end of the frame. */
#define LINKTYPE_FRELAY_WITH_DIR 206
/* Link Access Procedure, Balanced (LAPB), as specified by ITU-T Recommendation X.25 , preceded with a one-byte pseudo-header with a zero value meaning received by this host (DCE->DTE) and a non-zero value meaning sent by this host (DTE->DCE). */
#define LINKTYPE_LAPB_WITH_DIR 207
/* IPMB over an I2C circuit, with a Linux-specific pseudo-header */
#define LINKTYPE_IPMB_LINUX 209
/* IEEE 802.15.4 Low-Rate Wireless Networks, with each packet having the FCS at the end of the frame, and with the PHY-level data for the O-QPSK, BPSK, GFSK, MSK, and RCC DSS BPSK PHYs (4 octets of 0 as preamble, one octet of SFD, one octet of frame length + reserved bit) preceding the MAC-layer data (starting with the frame control field). */
#define LINKTYPE_IEEE802_15_4_NONASK_PHY 215
/* USB packets, beginning with a Linux USB header, as specified by the struct usbmon_packet in the Documentation/usb/usbmon.txt file in the Linux source tree. All 64 bytes of the header are present. All fields in the header are in host byte order. When performing a live capture, the host byte order is the byte order of the machine on which the packets are captured. When reading a pcap file, the byte order is the byte order for the file, as specified by the file's magic number; when reading a pcapng file, the byte order is the byte order for the section of the pcapng file, as specified by the Section Header Block. For isochronous transfers, the ndesc field specifies the number of isochronous descriptors that follow. */
#define LINKTYPE_USB_LINUX_MMAPPED 220
/* Fibre Channel FC-2 frames, beginning with a Frame_Header. */
#define LINKTYPE_FC_2 224
/* Fibre Channel FC-2 frames, beginning an encoding of the SOF, followed by a Frame_Header, and ending with an encoding of the SOF. The encodings represent the frame delimiters as 4-byte sequences representing the corresponding ordered sets, with K28.5 represented as 0xBC, and the D symbols as the corresponding byte values; for example, SOFi2, which is K28.5 - D21.5 - D1.2 - D21.2, is represented as 0xBC 0xB5 0x55 0x55. */
#define LINKTYPE_FC_2_WITH_FRAME_DELIMS 225
/* Solaris ipnet pseudo-header , followed by an IPv4 or IPv6 datagram. */
#define LINKTYPE_IPNET 226
/* CAN (Controller Area Network) frames, with a pseudo-header followed by the frame payload. */
#define LINKTYPE_CAN_SOCKETCAN 227
/* Raw IPv4; the packet begins with an IPv4 header. */
#define LINKTYPE_IPV4 228
/* Raw IPv6; the packet begins with an IPv6 header. */
#define LINKTYPE_IPV6 229
/* IEEE 802.15.4 Low-Rate Wireless Network, without the FCS at the end of the frame. */
#define LINKTYPE_IEEE802_15_4_NOFCS 230
/* Raw D-Bus messages , starting with the endianness flag, followed by the message type, etc., but without the authentication handshake before the message sequence. */
#define LINKTYPE_DBUS 231
/* DVB-CI (DVB Common Interface for communication between a PC Card module and a DVB receiver), with the message format specified by the PCAP format for DVB-CI specification */
#define LINKTYPE_DVB_CI 235
/* Variant of 3GPP TS 27.010 multiplexing protocol (similar to, but not the same as, 27.010). */
#define LINKTYPE_MUX27010 236
/* D_PDUs as described by NATO standard STANAG 5066, starting with the synchronization sequence, and including both header and data CRCs. The current version of STANAG 5066 is backwards-compatible with the 1.0.2 version , although newer versions are classified. */
#define LINKTYPE_STANAG_5066_D_PDU 237
/* Linux netlink NETLINK NFLOG socket log messages. */
#define LINKTYPE_NFLOG 239
/* Pseudo-header for Hilscher Gesellschaft für Systemautomation mbH netANALYZER devices , followed by an Ethernet frame, beginning with the MAC header and ending with the FCS. */
#define LINKTYPE_NETANALYZER 240
/* Pseudo-header for Hilscher Gesellschaft für Systemautomation mbH netANALYZER devices , followed by an Ethernet frame, beginning with the preamble, SFD, and MAC header, and ending with the FCS. */
#define LINKTYPE_NETANALYZER_TRANSPARENT 241
/* IP-over-InfiniBand, as specified by RFC 4391 section 6 */
#define LINKTYPE_IPOIB 242
/* MPEG-2 Transport Stream transport packets, as specified by ISO 13818-1/ ITU-T Recommendation H.222.0 (see table 2-2 of section 2.4.3.2 Transport Stream packet layer). */
#define LINKTYPE_MPEG_2_TS 243
/* Pseudo-header for ng4T GmbH's UMTS Iub/Iur-over-ATM and Iub/Iur-over-IP format as used by their ng40 protocol tester , followed by frames for the Frame Protocol as specified by 3GPP TS 25.427 for dedicated channels and 3GPP TS 25.435 for common/shared channels in the case of ATM AAL2 or UDP traffic, by SSCOP packets as specified by ITU-T Recommendation Q.2110 for ATM AAL5 traffic, and by NBAP packets for SCTP traffic. */
#define LINKTYPE_NG40 244
/* Pseudo-header for NFC LLCP packet captures , followed by frame data for the LLCP Protocol as specified by NFCForum-TS-LLCP_1.1 */
#define LINKTYPE_NFC_LLCP 245
/* Raw InfiniBand frames, starting with the Local Routing Header, as specified in Chapter 5 Data packet format of InfiniBand™ Architectural Specification Release 1.2.1 Volume 1 - General Specifications */
#define LINKTYPE_INFINIBAND 247
/* SCTP packets, as defined by RFC 4960 , with no lower-level protocols such as IPv4 or IPv6. */
#define LINKTYPE_SCTP 248
/* USB packets, beginning with a USBPcap header */
#define LINKTYPE_USBPCAP 249
/* Serial-line packet header for the Schweitzer Engineering Laboratories RTAC product , followed by a payload for one of a number of industrial control protocols. */
#define LINKTYPE_RTAC_SERIAL 250
/* Bluetooth Low Energy air interface Link Layer packets, in the format described in section 2.1 PACKET FORMAT of volume 6 of the Bluetooth Specification Version 4.0 (see PDF page 2200), but without the Preamble. */
#define LINKTYPE_BLUETOOTH_LE_LL 251
/* Linux Netlink capture encapsulation */
#define LINKTYPE_NETLINK 253
/* Bluetooth Linux Monitor encapsulation of traffic for the BlueZ stack */
#define LINKTYPE_BLUETOOTH_LINUX_MONITOR 254
/* Bluetooth Basic Rate and Enhanced Data Rate baseband packets */
#define LINKTYPE_BLUETOOTH_BREDR_BB 255
/* Bluetooth Low Energy link-layer packets */
#define LINKTYPE_BLUETOOTH_LE_LL_WITH_PHDR 256
/* PROFIBUS data link layer packets, as specified by IEC standard 61158-4-3, beginning with the start delimiter, ending with the end delimiter, and including all octets between them. */
#define LINKTYPE_PROFIBUS_DL 257
/* Apple PKTAP capture encapsulation */
#define LINKTYPE_PKTAP 258
/* Ethernet-over-passive-optical-network packets, starting with the last 6 octets of the modified preamble as specified by 65.1.3.2 Transmit in Clause 65 of Section 5 of IEEE 802.3 , followed immediately by an Ethernet frame. */
#define LINKTYPE_EPON 259
/* IPMI trace packets, as specified by Table 3-20 Trace Data Block Format in the PICMG HPM.2 specification The time stamps for packets in this format must match the time stamps in the Trace Data Blocks. */
#define LINKTYPE_IPMI_HPM_2 260
/* Z-Wave RF profile R1 and R2 packets , as specified by ITU-T Recommendation G.9959 , with some MAC layer fields moved. */
#define LINKTYPE_ZWAVE_R1_R2 261
/* Z-Wave RF profile R3 packets , as specified by ITU-T Recommendation G.9959 , with some MAC layer fields moved. */
#define LINKTYPE_ZWAVE_R3 262
/* Formats for WattStopper Digital Lighting Management (DLM) and Legrand Nitoo Open protocol common packet structure captures. */
#define LINKTYPE_WATTSTOPPER_DLM 263
/* Messages between ISO 14443 contactless smartcards (Proximity Integrated Circuit Card, PICC) and card readers (Proximity Coupling Device, PCD), with the message format specified by the PCAP format for ISO14443 specification */
#define LINKTYPE_ISO_14443 264
/* Radio data system (RDS) groups, as per IEC 62106, encapsulated in this form */
#define LINKTYPE_RDS 265
/* USB packets, beginning with a Darwin (macOS, etc.) USB header */
#define LINKTYPE_USB_DARWIN 266
/* SDLC packets, as specified by Chapter 1, DLC Links, section Synchronous Data Link Control (SDLC) of Systems Network Architecture Formats, GA27-3136-20 , without the flag fields, zero-bit insertion, or Frame Check Sequence field, containing SNA path information units (PIUs) as the payload. */
#define LINKTYPE_SDLC 268
/* LoRaTap pseudo-header , followed by the payload, which is typically the PHYPayload from the LoRaWan specification */
#define LINKTYPE_LORATAP 270
/* Protocol for communication between host and guest machines in VMware and KVM hypervisors. */
#define LINKTYPE_VSOCK 271
/* Messages to and from a Nordic Semiconductor nRF Sniffer for Bluetooth LE packets, beginning with a pseudo-header */
#define LINKTYPE_NORDIC_BLE 272
/* DOCSIS packets and bursts, preceded by a pseudo-header giving metadata about the packet */
#define LINKTYPE_DOCSIS31_XRA31 273
/* mPackets, as specified by IEEE 802.3br Figure 99-4, starting with the preamble and always ending with a CRC field. */
#define LINKTYPE_ETHERNET_MPACKET 274
/* DisplayPort AUX channel monitoring data as specified by VESA DisplayPort(DP) Standard preceded by a pseudo-header */
#define LINKTYPE_DISPLAYPORT_AUX 275
/* Linux cooked capture encapsulation v2 */
#define LINKTYPE_LINUX_SLL2 276
/* Openvizsla FPGA-based USB sniffer */
#define LINKTYPE_OPENVIZSLA 278
/* Elektrobit High Speed Capture and Replay (EBHSCR) format */
#define LINKTYPE_EBHSCR 279
/* Records in traces from the http://fd.io VPP graph dispatch tracer, in the the graph dispatcher trace format */
#define LINKTYPE_VPP_DISPATCH 280
/* Ethernet frames, with a switch tag inserted between the source address field and the type/length field in the Ethernet header. */
#define LINKTYPE_DSA_TAG_BRCM 281
/* Ethernet frames, with a switch tag inserted before the destination address in the Ethernet header. */
#define LINKTYPE_DSA_TAG_BRCM_PREPEND 282
/* IEEE 802.15.4 Low-Rate Wireless Networks, with a pseudo-header containing TLVs with metadata preceding the 802.15.4 header. */
#define LINKTYPE_IEEE802_15_4_TAP 283
/* Ethernet frames, with a switch tag inserted between the source address field and the type/length field in the Ethernet header. */
#define LINKTYPE_DSA_TAG_DSA 284
/* Ethernet frames, with a programmable Ethernet type switch tag inserted between the source address field and the type/length field in the Ethernet header. */
#define LINKTYPE_DSA_TAG_EDSA 285
/* Payload of lawful intercept packets using the ELEE protocol The packet begins with the ELEE header; it does not include any transport-layer or lower-layer headers for protcols used to transport ELEE packets. */
#define LINKTYPE_ELEE 286
/* Serial frames transmitted between a host and a Z-Wave chip over an RS-232 or USB serial connection, as described in section 5 of the Z-Wave Serial API Host Application Programming Guide */
#define LINKTYPE_Z_WAVE_SERIAL 287
/* USB 2.0, 1.1, or 1.0 packet, beginning with a PID, as described by Chapter 8 Protocol Layer of the the Universal Serial Bus Specification Revision 2.0 */
#define LINKTYPE_USB_2_0 288
/* ATSC Link-Layer Protocol frames, as described in section 5 of the A/330 Link-Layer Protocol specification, found at the ATSC 3.0 standards page , beginning with a Base Header */
#define LINKTYPE_ATSC_ALP 289

#endif // _CPCAPNG_LINKTYPES_H_

