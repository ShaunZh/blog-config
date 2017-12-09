---
title: HTML&CSS
date: 2017-09-09 15:15:22
categories:
tags: 面试相关
---

## HTML 语义化
语义化的含义就是：**让正确的标签做正确的事**
**为什么要语义化？**
- 在CSS丢失或没有CSS时，页面仍然能够呈现较为清晰的结构
- 有利于SEO，有助于爬虫抓取抓取更多有效信息，因为搜索引擎的爬虫也要依赖标签来确定上下文和各个关键字的权重
- 方便其他设备的解析。向PAD、手机等设备对CSS的解析没有电脑那么强
- 便于团队开发和维护

## html5 新增了哪些新特性
- 新的结构化标签，如：header、section、article、footer、nav等更加语义化的标签
- 音视频标签：audio和video
- 动画的支持：canvas
- 新的表单控件：calendar、date、time、email、url
- 离线存储：localStorage、sessionStorage
- 新的跨域通信机制：window.postMessage

## 为什么利用多个域名来存储网站资源会更有效
- CDN 缓存更方便
- 突破浏览器的并发限制
- 节约主域名的连接数，优化页面响应
- 节约cookie带宽


## CSS 相关
### CSS都有哪些选择器？
- 基本选择器
  - 元素选择器
  - id选择器
  - class选择器
  - 一些关系选择器，例如：>(直接子元素), +(相邻兄弟选择器)，
- 属性选择器
  例如：`E[attr], E[attr*="value"], E[attr^="value"], E[attr$="value"]`
- 伪类选择器
  例如：`':first-child', ':last-child'`
- 伪元素选择器
  例如：`'::before', '::after', '::first-letter'`

**伪类和伪元素的区别**
其主要区别是：*有没有从创建一个文档树之外的元素*，如果创造了新的元素，则是伪元素，如果没有，则是伪类
例如：`:first-child`：其选择的是第一个子元素，说明没有创造新的元素，所以它是伪类，
`::before`：在元素的前面添加一个新元素，它创建了新的元素，所以是伪元素 
参考：[伪元素和伪类](http://www.alloyteam.com/2016/05/summary-of-pseudo-classes-and-pseudo-elements/)

###通过哪些CSS属性可以使一个元素不出现在浏览器可视范围内
基本方法：
- `display: none`
- `visibility: hidden`
技巧性的：
- 设置宽高为0
- 设置透明度为0：opacity
- 设置`z-index: -1000em`，其实就是设置元素的层级关系为超级低

###超链接访问过后hover样式就不出现的问题是什么？如何解决？
主要是对a链接的伪元素属性没有设置好，设置顺序为：*link，visited，hover，active*

### 什么是Css Hack？ie6,7,8的hack分别是什么？
CSS Hack就是：**针对不同的浏览器编写不同的CSS**

最简单的区分ie6、ie7、ie8的CSS Hack，如下所示：
```
.color {
    background-color: #CC00FF;       // 所有浏览器都能识别
    background-color: #FF0000\9;     // 只有IE6、 IE7、IE8能识别
    *background-color: #0066FF;      // IE6、IE7能识别
    +background-color: pink;         // 只有IE7能识别
    _background-color: #009933;      // 只有IE6能识别
}
```


## DIV + CSS 布局 与 table布局的优缺点
div + css 布局的优点
- 符合W3C标准，结构、行为和样式的分离
- 结构清晰，便于扩展
- 有利于搜索引擎检索，利于SEO

参考：[为什么不使用table布局](https://stackoverflow.com/questions/83073/why-not-use-tables-for-layout-in-html)
