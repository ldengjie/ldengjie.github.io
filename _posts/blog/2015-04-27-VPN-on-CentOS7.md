---
layout: post
title: CentOS7 ��װopenvpn ,�������������������
description: PPTP,L2TP VPN����GREЭ��,��Ҫ·����֧��,openvpn���ܴ���,�ҿ��������ö˿�
category: blog 
---

#Ե��#

������������������,һ����3G,������ķ�����������������������,ͬʱ���˵ĵ��Է�����������������������,��������3G/month��,�ʿ���ͨ����������������������,��ͨ�û��ڷ�������ֻ��SSH�˻�,������SSH ���(SSH -D 5555 xxx@xxxx)��SOCKS����,���proxifier��ProxyCap�����ó�ȫ�ִ���,��ȻSOCKS5֧��UDP,��SSH��֧��UDP,�������ִ���ֻ����ת��TCP���ݰ�,���������ҳ����,���󲿷���Ϸ��QQ��ʹ��UDPЭ��,����ż�����DOTA2������˵���ǲ�����.

���������������Ƴ������������(VPS),��Scientific Linux 7(��RedHat/CentOSͬһ��ϵ) ��win7�����ѡ��,ӵ��ROOTȨ�޺�����IP,�����Ϳ�����VPS�ϰ�װVPN����,��������������VPN������������,��ʱ���VPN��������������·��������.·���������൱���ܵ��������VPN��ΰ��֮��,���������������.

#��װ#

����μ�[Centos7(Linux)��OpenVPN��װ ���ý̳�](http://blog.csdn.net/mimi00x/article/details/40383285)�����½�Ϊ��������.

> "# "Ϊ��������rootȨ��������

> "$ "Ϊ�ͻ�����ͨȨ��������

> "//"Ϊע��

##1.��װOpenVPN##


    //��װgcc openssl lzo pam 
    # yum install -y gcc openssl-devel lzo-devel pam-devel
    
    //[����openvpn-2.3.4](http://www.softown.cn/soft/openvpn/linux),��ѹ
    # tar zxf openvpn-2.3.4.tar.gz
    
    //���밲װ,Ĭ�ϵ�Դ��������Ŀ¼,������~/��
    # cd ~/openvpn-2.3.4
    # ./configure;make;make install
    
##2.����֤��##

    //[����easy-rsa](http://pan.baidu.com/s/1o66Yaz4),��ѹ,�����е� easy-rsa ���Ƶ������OpenVPN-2.3.4/��
    # unzip easy-rsa-release-2.x.zip

    //���� ~/openvpn-2.3.4/easy-rsa/2.0 
    # cp -r easy-rsa-release-2.x/easy-rsa  ~/openvpn-2.3.4/
    # cd ~/openvpn-2.3.4/easy-rsa/2.0 

    //����CA֤��
    //��ʼ������,�������ú��������������ر�����Ϣ,�ɱ༭vars�����Ϣ:
    //KEY_COUNTRY:���ڹ���
    //KEY_PROVINCE:����ʡ
    //KEY_CITY:���ڳ���
    //KEY_ORG:������֯
    //KEY_EMAIL:�����ַ
    //KEY_OU:������λ��������
    # vi vars
    # ./vars 
    //���֮ǰ����������֤�����Կ 
    # ./clean-all 
    //����CA֤�����Կ,��������� ֱ�ӻس�,���ʾ���ֶ�ʹ��"[]"�е�Ĭ��ֵ(Ҳ����ǰ��vars�ļ������õĲ���ֵ)���������".",���ʾ���ֶ�����.��������Ҫע��Common Name�ֶ�,���൱��֤���"�û���",��ȷ��ÿ��֤���Common Name�ֶ���Ψһ�� 
    # ./build-ca

    //���ɷ�������֤��
    # ./build-key-server server

    //���ɿͻ���֤��,����clientNameΪ�Զ���Ŀͻ�������(����:client1 client2 jim tom).�����ҪΪ����ͻ�������֤��,ֻ��Ҫ�ֱ�ִ�ж�μ���.
    # ./build-key clientName

    //���ɵϷơ��ն���������Կ,(�����������,���ĵȴ�������ϼ���).�Ϸơ��ն���������Կ��һ�ְ�ȫЭ��,���Զ����ݽ��м���
    # ./build-dh


    ##����������Ҫ�õ����ļ���:##
    ca.crt
    ca.key
    dh2048.pem (�������ı���KEY_SIZE��Ϊ1024,�������dh1024.pem)
    server.crt
    server.key
    ##�ͻ���client1��Ҫ�õ����ļ���:##
    ca.crt
    client1.crt
    client1.key (����client1���ݸ������ÿ���������ͬ)

##3.�޸������ļ�.conf,��׺���޸�Ϊ.ovpn��Ϊwindws�������ļ�##

    //Ϊ��������ÿ���ͻ��˵�configĿ¼�ֱ��дһ�������ļ�,�������˵������ļ�Ϊserver.conf,�ͻ��˵������ļ�Ϊclient.conf.OpenVPN�Ѿ���sample/sample-config-files��Ŀ¼��Ϊ�����ṩ����ص�ʾ���ļ�server.conf��client.conf
    # vi ~/openvpn-2.3.4/sample/sample-config-files/server.conf

    //�޸�����ѡ��
    port 51194            //ָ�������ı����˿ں�,Ĭ��Ϊ1194,�޸ĵ��Է��ö˿ڱ����
    dh dh2048.pem         //ָ���Ϸƺն����������ļ�·��,Ĭ��Ϊdh1024.pem
    server 10.88.0.0 255.255.255.0   //ָ�����������ռ�õ�IP��ַ�κ���������,�˴����õķ���������ռ��10.88.0.1.
    proto tcp //ָ�����õĴ���Э��,����ѡ��tcp��udp ,Ĭ��ΪUDP,�������Ϸ���ݶ���,�޸�ΪTCP,��UDP���ݰ��ŵ�TCP���ﴫ��,��֤�ߵ���ȷ����
    push "redirect-gateway def1 bypass-dhcp" //���÷�����Ϊ����·����,����ͻ����������߷�����,���������Ҫ������
    push "dhcp-option DNS 202.38.128.58"//���ÿͻ���DNS,����Ļ��ͻ���Ping��ͨ����
    push "dhcp-option DNS 202.38.128.10"

    //�ͻ��������ļ�client.conf
    vi ~/openvpn-2.3.4/sample/sample-config-files/client.conf
    //�޸�����ѡ��
    proto tcp            //������������˵ı���һ��
    remote sip 1194      //ָ�����ӵ�Զ�̷�������ʵ��IP��ַ�Ͷ˿ں�
    cert client1.crt     //ָ����ǰ�ͻ��˵�֤���ļ�·��,�޸�Ϊ�������ɵĿͻ���crt����
    key client1.key      //ָ����ǰ�ͻ��˵�˽Կ�ļ�·�� ,�޸�Ϊ�������ɵĿͻ���key����

##4.����֤����Կ��config##

    //OpenVPN��Ȼ���Է�Ϊ�ͻ��˺ͷ�����,�������ǵİ�װ��������ȫһ����,ֻ��ͨ����ͬ��֤��������ļ�����������.������,��������OpenVPN��Ŀ¼�´���һ��configĿ¼,�����������֤��,��Կ�ļ�,�����ļ���������Ŀ¼��.
    # mkdir ~/openvpn-2.3.4/config
    //����֤�����Կ�ļ���configĿ¼ 
    //��������
    # cd ~/openvpn-2.3.4/easy-rsa/2.0 
    # cp ca.crt ca.key server.crt server.key dh2048.pem ~/openvpn-2.3.4/config
    # cp ~/openvpn-2.3.4/sample/sample-config-files/server.conf ~/openvpn-2.3.4/config
    //�ͻ���
    # cd ~/openvpn-2.3.4/easy-rsa/2.0 
    # cp ca.crt client1.crt client1.key ~/openvpn-2.3.4/config 
    # cp ~/openvpn-2.3.4/sample/sample-config-files/client.conf ~/openvpn-2.3.4/config

##5.����OpenVPN##

    //��Linux��,���ǿ���ֱ��ִ����������������OpenVPN,������Ƿ�������,��ָ��server.conf�ļ���·��,������ǿͻ��˾�ָ��client.conf�ļ���·��.���������������ļ������õ��ļ�·���������configĿ¼��·��,�������Ҳֻ����configĿ¼�²�����������OpenVPN.����������κεط�����ʹ��������������OpenVPN,�����㽫�����ļ����ļ�·����صĲ���ȫ����Ϊ����·��.
    # openvpn �����ļ�·��

##6.���÷���ǽiptables NAT,����·��������ת������##

    //1.CentOS7����ǽĬ��Ϊfirewalld(Ĭ�ϲ�����),���ﰲװiptables����ǽ
    # yum install iptables.services
    //�鿴�Ƿ�װ��,����Ϊ����,����ʾLoaded: not-found (Reason: No such file or directory),����VPS����.
    # system status iptables
    iptables.service - IPv4 firewall with iptables
    Loaded: loaded (/usr/lib/systemd/system/iptables.service; disabled)
    Active: inactive (dead)
    //����iptables
    # systemctl start iptables

    //2.�������ط�������·��ת��
    # vi /etc/sysctl.conf
    net.ipv4.ip_forward = 1
    //�����ں�,ʹ֮��Ч
    # sysctl -p

    //3.����ת��
    # iptables -F
    # iptables -t nat -A POSTROUTING -s 192.168.2.0/24   -j SNAT --to-source 192.168.2.119
    # service iptables save
    # systemctl restart iptables

##7.��װ�ͻ���##

ǰ���ǵõ��ͻ��˵�ca.crt client1.crt client1.key client.conf

###MAC OS X###

1.[����Tunnelblick](http://www.macupdate.com/app/mac/16969/tunnelblick)

2.��װTunnelblick,��"���̹���"��"�޸�����Ȩ��",��Ϊ���������������.kert,�������Ӳ���

3.˫�� client.conf,�Ϳ����Զ���������

###Linux###

����������һ����Դ����,���밲װ,������������֤��,�������÷���ǽ,����Ϊ

0.[����openvpn-3.2.4.tar.gz](http://www.softown.cn/soft/openvpn/linux)

1 ���밲װ

4 �����ļ���config

5 ����:openvpn client.conf 

###windows###

1.[����OpenVPN](http://openvpn.ustc.edu.cn/)

2.��װʱ ϵͳ=win7,��������װ,win8��װTAP�������ִ���,��������.

3.���ļ����Ƶ�C:\program files\openvpn\config,Ҳ������C:\Program Files (x86)\OpenVPN\config

4.����ԱȨ������openvpn-gui.exe

#Ч��#

����ȫ��VPN,������ϵͳ�в�ѯ����.tcpdump�ο��ͻ������ݰ�����,���˿ͻ���IP(clip)�ͷ�������IP(sip)֮������ݰ�,������Ϊ�ǳ��ٵ�IPv6�㲥��

    $ sudo tcpdump host clip and ! sip
    05:21:28.086197 ARP, Request who-has 10.10.0.1 tell 10.10.5.251, length 28 
    05:21:28.092687 ARP, Reply 10.10.0.1 is-at 00:1b:21:b2:66:c9 (oui DCBX), length 28

�����ȶ�

<img src="../../file/2015-04-27-VPN-on-CentOS7-figure/tunnelblick.png"  alt="" align=center />  

����Ч��:

ipv6��վ����������,������������.

-------------------
#�����ο�����#

2. [ʹ��Proxifier ��ssh shadowsocks����תΪȫ�ִ���](http://boafanx.tabboa.com/77.boafanx)
1. tcpdump:�ػ��������ݰ� [Linux tcpdump�������](http://www.cnblogs.com/ggjucheng/archive/2012/01/14/2322659.html)
4. nc;�˿����ݼ�� [linux��nc��ʹ��](http://qing.blog.sina.com.cn/1285469314/4c9eb48233004b2l.html)
8. nmap:ɨ��˿� [NMAP �����̳�](http://drops.wooyun.org/tips/2002)
9. traceroute:����·�� [linux֮traceroute�÷����](http://yp.oss.org.cn/software/show_resource.php?resource_id=1057)
3. iptables:CentOS����ǽ [Iptables���ߵ�ʹ��](http://www.cnblogs.com/linuxer/archive/2012/04/10/2870538.html)
5. [iptablesʵ��·��ת��������](http://www.jbxue.com/LINUXjishu/3269.html)
6. PF:MAC OS X ����ǽ [PF APPLE�ٷ�����](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man5/pf.conf.5.html)
7. [PF: Getting Started](http://www.openbsd.org/faq/pf/config.html)

-------------------

##��Ϊʲôѡ��OpenVPN##

һ��ʼ���ż�ȥ,��װ��PPTP,��װ�����μ�[CentOS 6.3����PPTP VPN�ķ���](http://www.heminjie.com/system/linux/307.html),��ͬ��ϵ��ϵͳ��"����iptablesת��"�᲻һ��,cenos redhat sl��ϵ����������.

������ sipΪ��������IP,clipΪ�ͻ���IP.

�������Ӳ���,��nmapɨ��˿�,�˿�����

    # nmap sip

    Starting Nmap 6.40 ( http://nmap.org ) at 2015-04-24 01:01 CST
    Nmap scan report for sip
    Host is up (0.0000070s latency).
    Not shown: 997 closed ports
    PORT     STATE SERVICE
    22/tcp   open  ssh
    111/tcp  open  rpcbind
    1723/tcp open  pptp

��tcpdump�ֱ��ڿͻ��˺ͷ������˽�ȡ���ݰ�

    //�ͻ���
    $ sudo tcpdump host clip and sip

    //tcp �������ֽ�������
    23:19:14.735117 IP 10.10.5.251.60129  > sip.1723: Flags [S], seq 3346976484, win 65535, options [mss 1460,nop,wscale 5,nop,nop,TS val 1172463360 ecr 0,sackOK,eol], length 0
    23:19:14.742169 IP sip.1723 > 10.10.5.251.60129: Flags [S.], seq 3764887308, ack 3346976485, win 14480, options [mss 1460,sackOK,TS val 91220646 ecr 1172463360,nop,wscale 7], length 0
    23:19:14.742219 IP 10.10.5.251.60129  > sip.1723: Flags [.], ack 1, win 4117, options [nop,nop,TS val 1172463367 ecr 91220646], length 0
    
    //ͨ��1723�˿�tcp���ݰ�����������Ϣ,����GRE����ͨ��
    23:19:14.742251 IP 10.10.5.251.60129  > sip.1723: Flags [P.], seq 1:157, ack 1, win 4117, options [nop,nop,TS val 1172463367 ecr 91220646], length 156: pptp CTRL_MSGTYPE=SCCRQ PROTO_VER(1.0) FRAME_CAP(A) BEARER_CAP(A) MAX_CHAN(0) FIRM_REV(0) HOSTNAME() VENDOR()
    23:19:14.745603 IP sip.1723 > 10.10.5.251.60129: Flags [.], ack 157, win 122, options [nop,nop,TS val 91220653 ecr 1172463367], length 0
    23:19:14.762489 IP sip.1723 > 10.10.5.251.60129: Flags [P.], seq 1:157, ack 157, win 122, options [nop,nop,TS val 91220669 ecr 1172463367], length 156: pptp CTRL_MSGTYPE=SCCRP PROTO_VER(1.0) RESULT_CODE(1) ERR_CODE(0) FRAME_CAP() BEARER_CAP() MAX_CHAN(1) FIRM_REV(1) HOSTNAME(local) VENDOR(linux)
    23:19:14.762535 IP 10.10.5.251.60129  > sip.1723: Flags [.], ack 157, win 4112, options [nop,nop,TS val 1172463386 ecr 91220669], length 0
    23:19:14.762595 IP 10.10.5.251.60129  > sip.1723: Flags [P.], seq 157:325, ack 157, win 4112, options [nop,nop,TS val 1172463386 ecr 91220669], length 168: pptp CTRL_MSGTYPE=OCRQ CALL_ID(13008) CALL_SER_NUM(0) MIN_BPS(300) MAX_BPS(100000000) BEARER_TYPE(Any) FRAME_TYPE(E) RECV_WIN(64) PROC_DELAY(0) PHONE_NO_LEN(0) PHONE_NO() SUB_ADDR()
    23:19:14.766699 IP sip.1723 > 10.10.5.251.60129: Flags [P.], seq 157:189, ack 325, win 130, options [nop,nop,TS val 91220673 ecr 1172463386], length 32: pptp CTRL_MSGTYPE=OCRP CALL_ID(0) PEER_CALL_ID(13008) RESULT_CODE(1) ERR_CODE(0) CAUSE_CODE(0) CONN_SPEED(100000000) RECV_WIN(64) PROC_DELAY(0) PHY_CHAN_ID(0)
    23:19:14.766726 IP 10.10.5.251.60129  > sip.1723: Flags [.], ack 189, win 4111, options [nop,nop,TS val 1172463389 ecr 91220673], length 0
    23:19:14.766755 IP 10.10.5.251.60129  > sip.1723: Flags [P.], seq 325:349, ack 189, win 4111, options [nop,nop,TS val 1172463389 ecr 91220673], length 24: pptp CTRL_MSGTYPE=SLI PEER_CALL_ID(0) SEND_ACCM(0xffffffff) RECV_ACCM(0xffffffff)

    //ͨ��GRE 47��Э�鴫������,����47�Ŷ˿�.
    23:19:14.784632 IP 10.10.5.251        > sip: GREv1, call 0, seq 1, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:14.811724 IP sip.1723 > 10.10.5.251.60129: Flags [.], ack 349, win 130, options [nop,nop,TS val 91220716 ecr 1172463389], length 0
    23:19:17.878070 IP 10.10.5.251        > sip: GREv1, call 0, seq 2, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:20.974037 IP 10.10.5.251        > sip: GREv1, call 0, seq 3, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:24.073192 IP 10.10.5.251        > sip: GREv1, call 0, seq 4, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:27.166156 IP 10.10.5.251        > sip: GREv1, call 0, seq 5, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:30.266323 IP 10.10.5.251        > sip: GREv1, call 0, seq 6, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:33.366152 IP 10.10.5.251        > sip: GREv1, call 0, seq 7, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:34.833645 IP 10.10.5.251.60129  > sip.1723: Flags [.], ack 189, win 4111, length 0
    23:19:34.837934 IP sip.1723 > 10.10.5.251.60129: Flags [.], ack 349, win 130, options [nop,nop,TS val 91240745 ecr 1172463389], length 0
    23:19:36.466142 IP 10.10.5.251        > sip: GREv1, call 0, seq 8, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:39.566115 IP 10.10.5.251        > sip: GREv1, call 0, seq 9, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
    23:19:42.666162 IP 10.10.5.251        > sip: GREv1, call 0, seq 10, ack 0, length 40: LCP, Conf-Request (0x01), id 1, length 22
   
    //tcp 4�����ֹر����� 
    23:19:45.020055 IP sip.1723 > 10.10.5.251.60129: Flags [F.], seq 189, ack 349, win 130, options [nop,nop,TS val 91250812 ecr 1172463389], length 0
    23:19:45.020094 IP 10.10.5.251.60129  > sip.1723: Flags [.], ack 190, win 4111, options [nop,nop,TS val 1172493608 ecr 91250812], length 0
    23:19:45.021416 IP 10.10.5.251.60129  > sip.1723: Flags [F.], seq 349, ack 190, win 4111, options [nop,nop,TS val 1172493609 ecr 91250812], length 0
    23:19:45.023934 IP sip.1723 > 10.10.5.251.60129: Flags [.], ack 350, win 130, options [nop,nop,TS val 91250930 ecr 1172493609], length 0
    
    //��������
    # tcpdump host clip and sip
    //tcp �������ֽ�������
    ...
    //ͨ��1723�˿�tcp���ݰ�����������Ϣ,����GRE����ͨ��
    ...
    //ͨ��GRE 47��Э�鴫������,����47�Ŷ˿�.
    00:36:27.519495 IP sip > 10.10.5.251: GREv1, call 13179, seq 0, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:27.556607 IP sip.pptp > 10.10.5.251.62482: Flags [.], ack 349, win 130, options [nop,nop,TS val 95853443 ecr 1177082162], length 0
    00:36:30.518295 IP sip > 10.10.5.251: GREv1, call 13179, seq 1, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:33.521385 IP sip > 10.10.5.251: GREv1, call 13179, seq 2, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:36.524472 IP sip > 10.10.5.251: GREv1, call 13179, seq 3, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:39.527595 IP sip > 10.10.5.251: GREv1, call 13179, seq 4, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:42.530681 IP sip > 10.10.5.251: GREv1, call 13179, seq 5, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:45.533800 IP sip > 10.10.5.251: GREv1, call 13179, seq 6, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:47.599935 IP 10.10.5.251.62482 > sip.pptp: Flags [.], ack 189, win 4111, length 0
    00:36:47.599999 IP sip.pptp > 10.10.5.251.62482: Flags [.], ack 349, win 130, options [nop,nop,TS val 95873486 ecr 1177082162], length 0
    00:36:48.536954 IP sip > 10.10.5.251: GREv1, call 13179, seq 7, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:51.540067 IP sip > 10.10.5.251: GREv1, call 13179, seq 8, length 41: LCP, Conf-Request (0x01), id 1, length 27
    00:36:54.543181 IP sip > 10.10.5.251: GREv1, call 13179, seq 9, length 41: LCP, Conf-Request (0x01), id 1, length 27
    
    //tcp 4�����ֹر����� 
    ...

TCP GRE Э�鲿�ֲμ�[TCPЭ���е��������ֺ��Ĵλ���(ͼ��)](http://blog.csdn.net/whuslei/article/details/6667471) [PPTP - GRE](http://blog.csdn.net/msptop/article/details/2451138) [PPTP/L2TPЭ�齲���Լ�Ӧ�ò���](http://blog.163.com/hlz_2599/blog/static/142378474201341511122929/),�Աȷ������Ϳͻ���û�н��յ��Է���GRE���ݰ�,��ʱ���߶��ѹر��˷���ǽ,�ʿ��ƶ�������֮���ĳ��·�����з���ǽ������GREЭ��,�����Ͼɲ�֧��.����һ��PPTP��L2TP�����ɲ�ȡ.

���ò�����OpenVPN.


##VPN����##

PPTP L2TP OpenVPN ���ֵ�����μ�:[VPNЭ��PPTP L2TP OpenVPN](http://www.cnblogs.com/adforce/p/3511692.html)

ժ¼����,�Ա�ԭ�Ĳ���:

> ###һ PPTP L2TP OpenVPN�������Э��ĸ���###
> 
> ####1 PPTP(Point to Point Tunneling Protocol,��Ե����Э��)Ĭ�϶˿ں�:1723####
> 
> PPTP,��PPTFЭ��.��Э������PPPЭ��Ļ����Ͽ�����һ���µ���ǿ�Ͱ�ȫЭ��,֧�ֶ�Э������ר����(VPN),����ͨ�����������֤Э��(PAP) ����չ�����֤Э��(EAP)�ȷ�����ǿ��ȫ��.����ʹԶ���û�ͨ������ISP ͨ��ֱ������Internet���������簲ȫ�ط�����ҵ��.
> 
> ��Ե����Э��(PPTP)��һ��֧�ֶ�Э������ר����������缼��,�������ڵڶ���.ͨ����Э��,Զ���û��ܹ�ͨ�� Microsoft Windows NT����վ Windows xp  Windows 2000 ��windows2003 windows7����ϵͳ�Լ�����װ�е�Ե�Э���ϵͳ��ȫ���ʹ�˾����,���ܲ������뱾��ISP,ͨ��Internet ��ȫ���ӵ���˾����.
> 
> PPTPЭ���ǵ�Ե����Э��,�佫���ư������ݰ��ֿ�,���ư�����TCP����.PPTPʹ��TCPЭ��,�ʺ���û�з���ǽ���Ƶ�������ʹ��.
> 
> [�ٶȰٿ�](http://baike.baidu.com/link?url=hHnpi2pyUWox7o6tbuGhyEi-jUPBmtpxlWRvVvE_LZfTAFmQOY2KPXqUzfAPHcql)
> 
> ####2 L2TP(Layer 2 Tunneling Protocol,�ڶ������Э��)####
> 
> L2TP��һ�ֹ�ҵ��׼��Internet���Э��,���ܴ��º�PPTPЭ������,����ͬ�����Զ��������������м���.����Ҳ�в�֮ͬ��,����PPTPҪ������ΪIP����,L2TPҪ���������ݰ��ĵ�Ե����ӣ�PPTPʹ�õ�һ���,L2TPʹ�ö������L2TP�ṩ��ͷѹ�� �����֤,��PPTP��֧��.
> 
> L2TP��һ��������·��Э��,����UDP.�䱨�ķ�Ϊ������Ϣ�Ϳ�����Ϣ����.������Ϣ��Ͷ�� PPP ֡,��֡��ΪL2TP���ĵ�������.L2TP����֤������Ϣ�Ŀɿ�Ͷ��,�����ݱ��Ķ�ʧ,�����ش�,��֧�ֶ�������Ϣ���������ƺ�ӵ������.������Ϣ���Խ��� ά������ֹ�������Ӽ��Ự,L2TPȷ����ɿ�Ͷ��,��֧�ֶԿ�����Ϣ���������ƺ�ӵ������.
> 
> L2TP�ǹ��ʱ�׼���Э��,�������PPTPЭ���Լ��ڶ���ת��L2FЭ����ŵ�,���������ʽʹPPP��ͨ����������Э��,����ATM SONET��֡�м�.����L2TPû���κμ��ܴ�ʩ,�����Ǻ�IPSecЭ����ʹ��,�ṩ�����֤.
> 
> L2TPʹ��UDPЭ��,һ����Դ�͸����ǽ,�ʺ����з���ǽ���� �������û�,�繫˾ ���� ѧУ�ȳ���ʹ��.
> 
> PPTP��L2TP�������������������ϲ�𲻴�,���ʹ��PPTP������,�Ǿ͸���ΪL2TP.
> 
> [�ٶȰٿ�](http://baike.baidu.com/link?url=t6G3hu_r6-pfi-GN8cCXg5Vx3F_Rk4fEdvXS80l2zstTub7gXMNQzOIPTKfjd_FU)
> 
> ####3 OpenVPN####
> 
> OpenVpn�ļ�����������������,�����SSLЭ��ʵ��.
> 
> ����������ʹ������ײ��̼���ʵ�ֵ�һ���������,��װ���������϶����һ������,��������������һ����������.������������Ӧ�ò����������,���Ӧ�����(��IE)������������������,����������Զ�ȡ��������,����������д���ʵ����ݵ���������,Ӧ�����Ҳ���Խ��յõ�.���������ںܶ�Ĳ���ϵͳ�¶�����Ӧ��ʵ��,��Ҳ��OpenVpn�ܹ���ƽ̨һ������Ҫ������.
> 
> OpenVPNʹ��OpenSSL����������������Ϣ:��ʹ����OpenSSL�ļ����Լ���֤����,��ζ��,���ܹ�ʹ���κ�OpenSSL֧�ֵ��㷨.���ṩ�˿�ѡ�����ݰ�HMAC������������ӵİ�ȫ��.����,OpenSSL��Ӳ������Ҳ�������������.
> 
> OpenVPN���е�ͨ�Ŷ�����һ����һ��IP�˿�,Ĭ�����Ƽ�ʹ��UDPЭ��ͨѶ,ͬʱTCPҲ��֧��.
> 
> ��ѡ��Э��ʱ��,��Ҫע��2���������֮�������״��,���и��ӳٻ��߶����϶�������,��ѡ��TCPЭ����Ϊ�ײ�Э��,UDPЭ�����ڴ��������Ӻ��ش�����,����Ҫ����ϲ��Э������ش�,Ч�ʷǳ�����.
> 
> OpenVPN��һ������SSL���ܵĴ�Ӧ�ò�VPNЭ��,��SSL VPN��һ��,֧��UDP��TCP���ַ�ʽ(˵��:UDP��TCP��2��ͨѶЭ��,����ͨ��UDP��Ч�ʻ�Ƚϸ�,�ٶ�Ҳ��ԽϿ�.���Ծ���ʹ��UDP���ӷ�ʽ,ʵ��UDPû��ʹ�õ�ʱ��,��ʹ��TCP���ӷ�ʽ).
> 
> �����������ڴ�Ӧ�ò�,������PPTP��L2TP��ĳЩNAT�豸���治��֧�ֵ����,���ҿ����ƹ�һЩ����ķ���(ͨ�׵㽲,�������������ĵط�������OpenVPN).
> 
> OpenVPN�ͻ���������Ժܷ�������·�ɱ�,ʵ�ֲ�ͬ��·(����ں͹���)��·��ѡ��,ʵ��һ����IP��VPN,��һ����IP��ԭ����.
> 
> [�ٶȰٿ�](http://baike.baidu.com/link?url=00I2C_Gm7Xvcma3QJYHCrJJ0-xcdcNbcSAMNyuxozggQ0LVxeOkZklkiMqbL_j37D0ucvHfsWmlaZbQUlhxO3q)
> 
>  
> 
> ###�� PPTP L2TP OpenVPN�������Э�����ȱ��Ա�###
> 
> ������:    PPTP > L2TP > OpenVPN

> �ٶ�:      PPTP > OpenVPN UDP > L2TP > OpenVPN TCP

> ��ȫ��:    OpenVPN > L2TP > PPTP

> �ȶ���:    OpenVPN > L2TP > PPTP

> ����������:OpenVPN > PPTP > L2TP
> 
>  
> 
> ###�� VPNЭ���ѡ��###
> 
> ����������ʹ��PPTP,�޷�ʹ�ÿ��Գ���L2TP,�԰�ȫ��Ҫ��ߵ�����ʹ��OpenVPN.�ֳ��豸�Ƽ�ʹ��L2TP.
> 
> PPTP:      ���,�������,������豸��֧�֣�

> L2TP:      ֧��PPTP���豸������֧�ִ��ַ�ʽ,�����Ը���,��Ҫѡ��L2TP/IPSec PSK��ʽ,������Ԥ������ԿPSK��

> OpenVPN:���ȶ�,�����ڸ������绷��,����Ҫ��װ����������������ļ�,�ϸ���.


