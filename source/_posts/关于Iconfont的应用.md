---
title: 关于Iconfont的应用
date: 2015-10-16 22:34:23
tags:
  - 图标解决方案
  - iconfont
categories: 工具使用
---
Github地址:<https://github.com/JohnWong/IconFont>
	
#### 使用指南
##### 安装IconFont
使用CocoaPods安装
添加pod 'IconFont', '~> 0.0.2'到你项目的Podfile中。

运行pod install或者pod update来安装。

这里需要注意的是字体内包含的字体名要与字体文件名一致。从iconfont.cn下载的字体可能需要重命名。点击下图字体项目的编辑项目按钮，Font Family一栏就是字体内包含的字体名，将下载解压后的ttf文件名修改为这个字体名。当然，也可以在下载后使用FontForge工具修改ttf文件内包含的字体名。

##### 引用头文件
在需要使用的地方引用头文件，或者在预编译pch文件中做全局引用：

	#import "TBCityIconFont.h"
 设置字体名称

系统会默认加载字体名称LLIconfont，如果字体名不是这个，则需要在使用字体之前设置字体的名称。例如在AppDelegate的-application:didFinishLaunchingWithOptions:方法中添加：

	[TBCityIconFont setFontName:@"LLIconfont"];
	
##### 创建UIImage
使用UIImage的category方法从字体创建UIImage：

	[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e601", 24, [UIColor blackColor])]
	
其中e601图标在字体中存放的Unicode字符位。如果字体从iconfont.cn网站下载，这个值可以在页面上图标下方找到。可能更好的方法是在另一个文件中将图标预定义好，方便管理，使用的时候也更加简洁。

// TBCityIconDefine.h

	#define kTBCityIconCheck TBCityIconInfoMake(@"\U0000e601", 24, [UIColor blackColor])
	[UIImage iconWithInfo:kTBCityIconAppreciate]
