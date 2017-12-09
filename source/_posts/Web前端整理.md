---
title: Web前端面试提问
date: 2017-09-06 16:24:45
categories: Web
tags: WEB
---
## React 与 Vue的区别
** 语法不同 **
- React使用的是JSX语法
- Vue使用的是模板语法

** 架构模式不同 **
- React是MVC架构
- Vue是MVVM架构

** 对state的管理不同 **
- React不能对state直接进行修改，必须通过`this.setState`进行修改
- Vue可以直接对state进行修改，修改后的数据会直接渲染到页面上

** 对移动端的支持 **
- React有React Native，支持移动端APP开发
- Vue没有

** 生态 **
- React 的生态比 Vue要大 

** 学习难度 **
- React 大部分是英文资料，而Vue中文教程支持完善

参考文章：[React还是Vue？](https://segmentfault.com/a/1190000009268926)

## Webpack 和 gulp的区别
从前端工程化的发展历程说起：
- 第一阶段
  在没有gulp等工具之前，开发人员一般通过工具将代码进行压缩，然后上线
- 第二阶段 gulp 出现
  gulp出现之后，文件的压缩、生成base64 就都交给gulp处理了，不需要我们自己手动通过工具来做这些事，但是gulp没有解决js模块化的问题

- 第三阶段 requirejs出现
  requirejs 主要用于js模块化编程，它基于AMD规范，现在的操作流程是，requirejs实现js的模块化编程并打包，然后通过gulp压缩处理

- 第四阶段 webpack出现
  webpack将所有的资源都看成一个模块，并通过loader进行引入，且同时支持commonjs、AMD和CMD等规范，所以，很多人就选择webpack进行js的模块化编程并打包，然后使用gulp进行压缩

- 第五阶段 webpack的plugins
  最后人们发现可以使用webpack的plugins，通过编写一些插件，来完成文件的压缩及其他很多gulp做的事情，同时，还可以利用npm中package.json的scripts来自定义命令，实现自动化，因此，很多人转向了webpack

**注意**：gulp一直没解决的问题是js模块化编程的文件依赖问题，这也是导致它的市场慢慢的被webpack抢占的原因

**关于webpack和gulp的选择**
当用webpack无法解决你的问题时，再考虑gulp是否能够实现

## CommonJS、AMD和CMD的区别
** CommonJS **
CommonJS是同步加载，表示必须要等到模块加载完成之后，才执行后面的操作，所以它只适用于服务器端编程，因为对于服务器，其模块文件一般存放在本地硬盘上，加载起来比较快，不用考虑非同步加载的情况；

** AMD **
AMD规范则是非同步加载模块，允许指定回调函数，所以它比较适合；
```
define (['package/lib'], function(lib) {
    function foo() {
        lib.log('hello world');
    }

    return {
        foo: foo
    };
});
```

而对于浏览器端而言，程序文件都存放在服务器端，其加载速度取决于网速， 
参考：[http://javascript.ruanyifeng.com/nodejs/module.html]


## http协议

## 快速排序

## 前端通信接口

## 各设计模式的应用场景

## 当代码更新后发布，如何解决重复访问时，访问的是缓存信息？
当更新代码时，给代码添加版本号

## ajax的优缺点？
**什么是ajax**
  ajax是通过JavaScript异步获取数据，进行局部页面刷新的技术

**优点**
- 提高用户体验
- 较少带宽并增加速度
- 提高工作效率
  因为有很多封装好的ajax类库，很方便就可以与服务器进行通信
- 支持异步操作

**缺点**
- 浏览器兼容性问题
  因为ajax高度依赖JavaScript，而不同的浏览器对于JavaScript的支持程度不同，因此存在有兼容性问题
- 增加web服务器的负载 
  例如：增加一个自动更新的功能，每隔几秒钟就发送一次请求，那么就会增加服务器的负担
- 不安全性
  因为是异步获取数据，所以导致调试不便

