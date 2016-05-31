---
title: 计算label中的渲染文字宽度
date: 2015-12-3 15:14:24
tags:
  - 文字宽度
categories: 问题解决
---
iOS动态获取UILabel的高度和宽度
#### 方法
	NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:textView.text];  
	textView.attributedText = attrStr;  
	NSRange range = NSMakeRange(0, attrStr.length);  
	NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典  
	// 计算文本的大小  
	CGSize textSize = [textView.text boundingRectWithSize:textView.bounds.size // 用于计算文本绘制时占据的矩形块  
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项  
                                           attributes:dic        // 文字的属性  
                                              context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil  
	NSLog(@"w = %f", textSize.width);  
	NSLog(@"h = %f", textSize.height); 

#### 弃用
在使用UILabel存放字符串时，经常需要获取label的长宽数据，本文列出了部分常用的计算方法。

1.获取宽度，获取字符串不折行单行显示时所需要的长度 

	CGSize titleSize = [aString sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];

	注：如果想得到宽度的话，size的width应该设为MAXFLOAT。


2.获取高度，获取字符串在指定的size内(宽度超过label的宽度则换行)所需的实际高度.

	CGSize titleSize = [aString sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

	注：如果想得到高度的话，size的height应该设为MAXFLOAT。


3.实际编程时，有时需要计算一段文字最后一个字符的位置，并在其后添加图片或其他控件（如info图标），下面代码为计算label中最后一个字符后面一位的位置的方法。

	CGSize sz = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, 40)];

	CGSize linesSz = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];

	if(sz.width <= linesSz.width) //判断是否折行 {
	lastPoint = CGPointMake(label.frame.origin.x + sz.width, label.frame.origin.y);  
	} else {  
	lastPoint = CGPointMake(label.frame.origin.x + (int)sz.width % (int)linesSz.width,linesSz.height - sz.height);  
	}
	
参考:<http://blog.csdn.net/iunion/article/details/12185077> 