---
layout: post
title: ��װ��ƻ����DELL 3020 MT ̨ʽ��
description: EFI+GPT+CLOVER+Yosemiteԭ��
category: blog 
---

Ӳ����Ϣ��̨ʽ��
�����ͺ�    ���� OptiPlex 3020 Mini Tower
����ϵͳ    Windows XP רҵ�� 32λ SP3 ( DirectX 9.0c )
������  Ӣ�ض� Core i5-4570 @ 3.20GHz �ĺ�
����    ���� 040DDP (Ӣ�ض� Haswell)
�ڴ�    4 GB ( ����ʿ DDR3 1600MHz )
��Ӳ��  ϣ�� ST500DM002-1BD142 ( 500 GB / 7200 ת/�� )
�Կ�    ATI Radeon HD 8490 
��ʾ��  ���� DELF05F DELL E2215HV ( 21.7 Ӣ�� )
����    ����-LG DVD+-RW GHB0N DVD��¼��
����    ���� ALC280 @ Ӣ�ض� Haswell �߱�����Ƶ
����    ���� RTL8168/8111/8112 Gigabit Ethernet Controller / ����

��װ������
efi+gpt+clover+10.10.2ԭ��

��װ���̣�

SSD��̬Ӳ��(��SATA0��)+��еӲ��(��SATA1��)��ȫ�̰�װ������˫ϵͳ

�ε�ATI Radeon HD 8490��DVI+DP������������DSDT+FB������������DVIתVGA��DPתVGA��

��������HD4600��VGA+DP����������VGA�ӿڣ�ֻ����DPתVGA��

0.����U��������+��װ�̣�OS X��������
0.1 ���� ������2Gʱ��
0.1.1��һ������(��ʵ����������������һ��ΪEFI�������ڶ���Ϊ�������õķ���)����ʽMac OS Extended(Journaled)
0.1.2������������1:FAT32 200M 2:Mac OS Extended(Journaled) 7GB 3:exFat ���µĿռ�
![](2015-03-20-install-yosemite-on-dell-3020-mini-tower/0.1.2_0.png)
![](2015-03-20-install-yosemite-on-dell-3020-mini-tower/0.1.2_1.png)
![](2015-03-20-install-yosemite-on-dell-3020-mini-tower/0.1.2_2.png)




0.2 д��10.10.app��
sudo 10.10.app/Contents/Resources/createinstallmedia --volume U��λ�� --applicationpath 10.10.app --no interaction
���磺
sudo /Volumes/UPan/OS/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume /Volumes/OSU/ --applicationpath /Volumes/UPan/OS/Install\ OS\ X\ Yosemite.app --no interaction



0.3 clover ��װ��U��(ѡ��U�̣���ʵ�ǰ�װ��U�̵�EFI����)
���� http://sourceforge.net/projects/cloverefiboot/
0.3.1��һ������ʱ��
��ʽ��EFI ΪFAT32F���� ������clover configer ������
$ diskutil list
$ sudo newfs_msdos -v EFI -F 32 /dev/rdisk3s1
��������ʱ��ֱ�Ӱ�װѡ��200M��FAT������
0.3.2��װΪEFIģʽ








0.3.3 clover ����

����Ĭ��ѡ��ȫ����գ�������injectATI INTEL NV,Ȼ�� drivers64UEFI/�м���HFSPlus.efi ,ɾ��VBoxHfs-64.efi.//���������AppleACPIPlatform + IOPCIFamily ����

����FakeSMC.kext

���ˣ� 
Boot:  kext-dev-mode=1 
System Parameters:Inject Kexts=yes //����kexts/10.10/�µ����������أ�����FakeSMC.kext..
Devices:USB Inject=yes FixOwnership=yes //������� waitting on <dict ID="0">....

�μ�http://www.tonymacx86.com/yosemite-desktop-guides/144426-how-install-os-x-yosemite-using-clover.html

1.��װϵͳ
1.0 ת��Ӳ�̴�MBR��GPT�������INTEL SSD û��ת�������ɹ��ˣ�����Ĭ��ΪGPT��.

1.1 ��װʱBIOS����
Ӳ��AHCIģʽ������Ҫ�ر�USB3.0
EFI+GPT

1.2 �ų����
û�����
1.3 ��װϵͳ
ѡ������->���̹���->��װ��SSD���������ʮ������
����һ�Σ�U��������ѡ��"Install ..."������ʮ��������
������ѡ�� SSDӲ�� ����ϵͳ����


1.4 ��װclover��Ӳ��EFI��������������ΪEFI+GPT
ת��EFI����ΪFAT32��ʽ���Ա��Ժ�װMAC+WINDOWS˫ϵͳ,
$ diskutil list
$ sudo newfs_msdos -v EFI -F 32 /dev/rdisk0s1

Boot: -v kext-dev-mode=1 
Devices:USB Inject=yes FixOwnership=yes��?��
����FakeSMC.kext 

2.��װ����
2.1�Կ�
Graphics:Inject Intel=yes,ig-platform-id=0x0d220003//(����HD4600)
Ingect EDID =yes��Custom EDID=....//��ʶ����ʾ��)
2.1.1 ��ô�õ�EDID��
�������ӵ���ƻ���ϣ���SwitchResX�õ���
2.2����
��װVoodooHDA.pmg ,�����е��������޸�kext��info.list�е�iGain=0,iMix=90
2.3����
RealtekRTL8111.kext��kexts/10.10
2.4 ������������Ҫclover����
System Parameters:Inject Kexts=yes ��No Caches=yes










3.����
3.1��Ƶ��
����Ҫ,�Զ���Ƶ

4.  �ƶ���ý������ļ��е��ڶ���Ӳ��
lidj$ sudo mv Movies/ /Volumes/SecMedia/
lidj$ ln -s /Volumes/SecMedia/Movies/ Movies

