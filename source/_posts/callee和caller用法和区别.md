---
title: callee和caller用法和区别
date: 2017-09-10 11:04:14
categories:
tags: Javascript
---
## 简介
从字面上看，`callee`的意思是*被调用者*， `caller`的意思是*调用者*；
在JavaScript MDN上可以看到比较官方的解释：
- [callee](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments/callee): 指向当前被调用的函数
- [caller](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments/caller): 指向调用当前函数的函数

## 用法
```
var readBook = function(){
    console.log(arguments.callee);//这里返回的是readBook函数
    console.log(arguments.caller);//这里返回的应该是go函数，注意是“应该”
};
var go = function(){
    readBook();
};
go();
```
然而运行一下这串代码就会发现，callee确实是返回正在执行的参数readBook，而caller返回的是undefined。

在[caller的官方文档中](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments/caller)可以发现，`arguments.caller`已经不被推荐，但是可以仍然可以通过`Function.caller`访问，

如:
```
function whoCalled() {
   if (whoCalled.caller == null)
      console.log('I was called from the global scope.');
   else
      console.log(whoCalled.caller + ' called me!');
}
```

## 注意
值得注意的是，在 **严格模式**下，使用`arguments.callee`和`Function.caller`时浏览器都会抛出错误，还有在 **严格模式**下，假如给caller属性赋值的话，同样也会抛出错误。

## 实例
在实现递归的时候，可以达到解耦的作用，我们可以不必理会函数名是什么。例如下面的阶乘函数：
```
function factorial(number){
  if(number <= 1){
    return 1;
  }else{
    return number*arguments.callee(number-1);
  }
}
factorial(100);
```

## 兼容性
几乎所有浏览器都支持 **callee**属性，而对于 **caller**则并基本上不支持，尽量不要使用。

## 参考
[caller](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments/caller)
[callee](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments/callee)
