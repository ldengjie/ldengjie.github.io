---
layout: post  
title: 安装黑苹果到DELL 3020 MT 台式机  
description: EFI+GPT+CLOVER+Yosemite原版  
category: blog   
---
2213


硬件信息：台式机  
电脑型号    戴尔 OptiPlex 3020 Mini Tower  
操作系统    Windows XP 专业版 32位 SP3 ( DirectX 9.0c )  
处理器  英特尔 Core i5-4570 @ 3.20GHz 四核  
主板    戴尔 040DDP (英特尔 Haswell)  
内存    4 GB ( 海力士 DDR3 1600MHz )  
主硬盘  希捷 ST500DM002-1BD142 ( 500 GB / 7200 转/分 )  
显卡    ATI Radeon HD 8490   
显示器  戴尔 DELF05F DELL E2215HV ( 21.7 英寸 )  
光驱    日立-LG DVD+-RW GHB0N DVD刻录机  
声卡    瑞昱 ALC280 @ 英特尔 Haswell 高保真音频  
网卡    瑞昱 RTL8168/8111/8112 Gigabit Ethernet Controller / 戴尔  


安装方法：  

efi+gpt+clover+10.10.2原版  
  
安装过程：  
  
SSD固态硬盘(在SATA0口)+机械硬盘(在SATA1口),全盘安装不存在双系统  
  
拔掉ATI Radeon HD 8490(DVI+DP),曾尝试了DSDT+FB,但驱动不了DVI转VGA和DP转VGA。  
  
驱动核显HD4600(VGA+DP),不能用VGA接口,只能用DP转VGA。  
  
0 制作U盘引导盘+安装盘(OS X下制作)  
0.1 分区,大于2G时,  
0.1.1分一个分区(其实生成两个分区,第一个为EFI分区,第二个为这里设置的分区)：格式Mac OS Extended(Journaled)  
0.1.2分三个分区,1:FAT32 200M 2:Mac OS Extended(Journaled) 7GB 3:exFat 余下的空间  

<img src="2015-03-20-install-yosemite-on-dell-3020-mini-tower/0.1.2_0.png" width = "400" alt="" align=center />

