---
title: Promise初探
date: 2017-09-11 16:01:40
categories:
tags: Javascript
---
## Promise是什么？
**Promise**是一个进行 **异步处理的对象**，并且其提供了一些 **标准化的接口**，在使用时，必须按照统一的编码方式进行编码，

## Promise解决了什么问题
JavaScript是 **单线程工作**，意味着两段脚本不能同时运行，必须一个接一个运行，
如果要执行异步操作，只能通过 **回调函数和事件**，回调函数嵌套太多会导致代码变得复杂，逻辑不清晰，不利于维护，而且容易导致 **回调地狱**，Promise的出现就是为了解决异步的问题

## 使用Promise
创建一个promise对象的流程如下：
1. `new Promise(fn)` 返回一个promise对象
2. 在`fn`中指定异步等处理
    - 处理结果正常的话，调用`resolve(处理结果值)`
    - 处理结果错误的话，调用`reject(Error对象)`

下面代码创造了一个`Promise`实例
```
var promise = new Promise(function(resolve, reject) {
  // ... some code

  if (/* 异步操作成功 */){
    resolve(value);
  } else {
    reject(error);
  }
});
```

代码分析：
   - Promise对象接收一个函数作为参数，该函数带有两个参数: `resolve`和`reject`，而`resolve`和`reject`都是函数，由Javascript引擎提供，不用自己部署；
   - `resolve`函数的作用是：将Promise对象的状态 **从"未完成"变为"成功**（即从pending变为resolved），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；
   - `reject`函数的作用是：将Promise对象的状态从 **"未完成"变为"失败"**(即从 pending变为rejected)，在异步操作失败时调用，并将异步操作报出的错误信息，作为参数传递出去；

在`Promise`实例生成以后，可以用`then`方法分别指定`resolved`状态和`rejected`状态的回调函数
```
promise.then(function(value) {
    // success
}, function(value) {
    // failure
})
```

`then`方法可以接受两个回调函数作为参数。
第一个回调函数是`Promise`对象的状态变为`resolved`时调用
第二个回调函数是`Promise`对象的状态变为`rejected`时调用。
其中第二个回调函数是可选的，不一定要提供。这两个函数都接收`Promise`对象传出的值作为**参数**，也就是在`Promise`对象中`resolve()`函数和`reject()`函数传出来的值

一个示例如下：
```
var getJSON = function(url) {
  var promise = new Promise(function(resolve, reject){
    var client = new XMLHttpRequest();
    client.open("GET", url);
    client.onreadystatechange = handler;
    client.responseType = "json";
    client.setRequestHeader("Accept", "application/json");
    client.send();

    function handler() {
      if (this.readyState !== 4) {
        return;
      }
      if (this.status === 200) {
        resolve(this.response);
      } else {
        reject(new Error(this.statusText));
      }
    };
  });

  return promise;
};

getJSON("/posts.json").then(function(json) {
  console.log('Contents: ' + json);
}, function(error) {
  console.error('出错了', error);
});
```

## Promise的特点
1. **对象的状态不受外界影响**
Promise对象的三种状态：
  - `pending`(进行时)
  - `fulfilled`(已成功)
  - `rejected`(已失败)
  **注意：**只有 **异步操作的结果**(例如：一个使用Promise封装的XMLHttpRequest，其异步操作的结果就是 *请求成功*或是 *请求失败*)，可以决定当前是哪一种状态，任何其他操作都无法改变这个状态，这也是`Promise`这个名字的由来
2. **一旦状态改变，就不会再变，任何时候都可以得到这个结果**。 Promise的状态改变只有两种情况：**从`pending`变为`fulfilled` 和 从`pending`变为`rejected`**。只要这两种情况发生了，状态就**凝固**了，不会再变了，会一直保持这个结果，这时就称为: **resolved(已定型)**。

## Promise的缺点
1. 无法取消`Promise`，一旦新建它就会立即执行，无法中途取消
2. 其次，如果不设置回调函数，`Promise`内部抛出的错误，不会反应到外部。
3. 当处于`pending`状态时，无法得知目前进展到哪一个阶段(刚刚开始还是即将完成)

参考：[JavaScript Promise：简介](https://developers.google.com/web/fundamentals/getting-started/primers/promises?hl=zh-cn)
[nodejs 异步实现](https://zhuanlan.zhihu.com/p/25562598)
[promise迷你书](http://liubin.org/promises-book/)

