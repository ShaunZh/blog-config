---
title: WebSocket学习
date: 2017-09-18 08:47:32
categories:
tags: WEB
---
WebSocket是一种网络通信协议

## 为什么需要WebSocket
因为HTTP协议有一个缺陷：**通信只能由客户端发起**；如果需要获取到服务器端的数据更新，只能由客户端轮询服务器端，这样 **效率极低且浪费资源**。
基于以上原因，WebSocket就出现了

## 简介
WebSocket协议2008年诞生，2011年成为国际标准。

最大特点：**服务器可以主动向客户端推送信息，客户端也可以主动向服务器发送信息，是真正的双向平等对话**

其他特点包括：
- 建立在TCP协议之上，服务器端的实现比较容易
- 与HTTP协议有着良好的兼容性。默认端口也是80和443，并且握手阶段采用HTTP协议，因此握手时不容易屏蔽，能通过各种HTTP代理服务器
- 数据格式比较轻量，性能开销小，通信高效
- 可发送文本，也可以发送二进制数据
- 没有同源限制，客户端可以与任意服务器通信
- 协议标识符是`ws`(如果加密，则为`wss`)，服务器网址就是URL

```
ws://example.com:80/some/path
```
![对比图](http://www.ruanyifeng.com/blogimg/asset/2017/bg2017051503.jpg)

## 客户端的简单示例
WebSocket的用法很简单
例子如下：
```
var ws = new WebSocket("wss://echo.websocket.org");

ws.onopen = function(evt) {
  console.log("Connection open ...");
  ws.send("Hello WebSocket!");
}

ws.onmessage = function(evt) {
  console.log("Received Message: " + evt.data);
  ws.close();
}

ws.onclose = function(evt) {
  console.log("Connection closed.");
}
```

## 客户端的API
### WebSocket构造函数
WebSocket 对象作为一个构造函数，用于新建WebSocket实例。
```
var ws = new WebSocket('ws://localhost:8080');
```
执行上面语句之后，客户端就会与服务器进行连接。
实例对象的所有属性和方法清单，参见[WebSocket](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)

### WebSocket.readyState
`readyState`属性返回实例对象的当前状态，共有四种。

```
  - CONNETCTION: 值为0，表示正在连接
  - OPEN: 值为1，表示连接成功，可以通信了
  - CLOSING: 值为2，表示连接正在关闭
  - CLOSED: 值为3，表示连接已经关闭，或者打开连接失败
```




### 参考
- [WebSocket教程](http://www.ruanyifeng.com/blog/2017/05/websocket.html)

