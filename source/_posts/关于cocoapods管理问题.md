---
title: 关于cocoapods管理问题
date: 2015-9-13 10:14:54
tags:
  - Cocoapods
categories: 问题解决
---
关于删除pods文件夹后换电脑拉取文件重建pod管理 提示错误为 
	
	Xcode - ld: library not found for -lPods -*******

解决方法是在建立完后进入

	Settings(Target) > Build Settings > Linking > 'Other Linker Flags'
	
删除除首行 *$(inherited)* 外的其他行  

然后再重新运行一遍 pod install 成功

