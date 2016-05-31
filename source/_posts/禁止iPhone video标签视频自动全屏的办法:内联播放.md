---
title: 禁止iPhone video标签视频自动全屏的办法/内联播放
date: 2016-3-13 08:14:54
tags:
  - 视频
  - 禁止iOS web页面的自动全屏播放
categories: 问题解决
---
iOS应用开发过程中有视频直播需求，选择使用乐视的直播服务，由于乐视的直播sdk过大，所以刚开始选择了使用web页播放。
iOS的web页面点击播放视频时会自动全屏播放，而应用的需求是边直播还要边操作，故要取消全屏这一效果。
方法：
视频播放，但需要禁止iOS web页面的自动全屏播放（前提必须使用video标签）。

原web页面代码如下:

	<video id="video" width="280" height="140">
	<source src="test.mp4" type="video/mp4">
	</video>

在iPhone safari 点击视频会弹出播放器进行全屏播放。
可以前端在 video 标签上加一个 “webkit-playsinline” 属性 ，如下：

	<video id="video" width="280" height="140" webkit-playsinline >
	<source src="test.mp4" type="video/mp4">
	</video>

iOS应用内，添加代码如下:

	webView.allowsInlineMediaPlayback = YES;


