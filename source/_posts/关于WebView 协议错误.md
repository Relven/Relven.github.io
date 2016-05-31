---
title: 关于WebView 协议错误
date: 2016-3-16 08:14:54
tags:
  - WebView协议错误
categories: 问题解决
---
提示信息：
	
	App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.

翻译：应用程序安全运输了明文HTTP协议（http://）资源负载是不安全的。暂时的异常可以通过您的应用程序的Info.plist文件配置。

在info.plist文件中配置  添加如图：

![Plist修改](/img/plist修改.png)

