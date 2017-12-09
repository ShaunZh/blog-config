---
title: Vue中使用Mixins
date: 2017-09-26 16:45:29
categories:
tags: Vue
---
假设现在有这么一种情况：有两个组件，它们有很多相似之处，有相同的逻辑，同时，它们也有很多不同的点，那么是将其分割开来作为两个组件？还是作为一个组件，然后通过`props`来进行功能实现？

不管选择哪种方案，都不是很完美。如果分为两个组件，那么当进行功能调整时，有可能每个组件都需要调整，增加工作量；如果合为一个组件，那么内部的逻辑会变得复杂， 不利于维护

**Mixins** 是Vue中一个很有用的功能，可以让我们编写类似于函数式编程风格的代码。**Mixins**允许我们 **封装函数功能**，以便在很多不同的组件中可以使用。如果采用正确的方式编写，它们将会是 **纯函数**——也就是说，它们不会更改功能范围之外的内容。

更加通俗的理解就是：**使用Mixins，可以将组件中公共的部分抽离出来，然后在需要使用的时候进行导入，可以精简代码，同时逻辑清晰**

## Basic example
现在有两个组件——*modal*和 *tooltip*，它们的主要功能是切换一个boolean类型的state，然后进行相应的显示，除了逻辑相似之外就没有什么相同点了

**modal 组件**
```js 
const Modal = {
    template: "#modal",
    data() {
        return {
            isShowing: false
        }
    },
    methods: {
        toggleShow() {
            this.isShowing = !this.isShowing;
        }
    },
    components: {
        appChild: Child
    }
}
```

**tooltip 组件**
```js 
const tooltip = {
    template: "#tooltip",
    data() {
        return {
            isShowing: false
        }
    },
    methods: {
        toggleShow() {
            this.isShowing = !this.isShowing;
        }
    },
    components: {
        appChild: Child
    }
}
```
提取上面两个组件中的相同逻辑：
```js 
const toggle = {
    data() {
        return {
            isShowing: false
        }
    },
    methods: {
        toggleShow() {
            this.isShowing = !this.isShowing;
        }
    }
}
// Modal 组件
const Modal = {
    template: "#modal",
    // 使用混合
    mixins: [toggle],
    components: {
        appChild；Child
    }
};

// Tooltip组件
const Tooltip = {
    template: "#tooltip",
    // 使用混合
    mixins: [toggle],
    components: {
        appChild: Child
    }
}
```
以上便是使用混合提取出相同的逻辑，然后在各个组件中使用的示例

完整例子代码查看: [这里](https://codepen.io/sdras/pen/101a5d737b31591e5801c60b666013db/)

## Usage
在实际应用中，可以创建一个 **mixins** 的文件夹用于存放mixins对象，如下所示：
![Vue mixins的文件结构](https://res.cloudinary.com/css-tricks/image/upload/c_scale,w_1000,f_auto,q_auto/v1496725448/toggle_ma4im5.jpg)

在Modal.vue中，我们可以import mixins对象来使用它，代码如下：
```js 
import Child from './Child'
import { toggle } from './mixins/toggle'

export default {
    name: 'modal',
    mixins: [toggle],
    components: {
        appChild: Child
    }
}
```
有一点很重要：虽然mixins是一个对象，但是在里面我们仍然可以使用Vue组件的的钩子函数，例如：`mounted`, `created`。。。

## 合并
分为两种情况考虑：组件和混合对象的同名选项下的值 **不是对象** 和 **是对象**
### 不是对象时
**如果同名选项的值不是对象，则混合为一个数组，依次调用**

当在组件中使用mixins对象，同时，组件中和mixins对象中有同名的钩子函数，这时同名的函数会被 **混合为一个数组**，在进行调用时，它们都会被调用，但是存在一个 **调用顺序**的问题：**mixins对象上的钩子函数会比对象自身的钩子函数先调用**：
```js 
var mixin = {
    created: function() {
        console.log('混合对象的钩子被调用')
    }
}

new Vue({
    mixins: [mixin],
    created: function() {
        console.log('组件钩子被调用')
    }
})

// => "混合对象的钩子被调用"
// => "组件钩子被调用"
```

### 是对象
**如果同名选项的值是对象，则混合为同一个对象，当其中两个对象键名冲突时，取组件对象的`键值对`**

```js
var mixin = {
    methods: {
        foo: function() {
            console.log('foo')
        },
        conflicting: function() {
            console.log('from mixin')
        }
    }
}

var vm = new Vue({
    mixins: [mixin],
    methods: {
        foo: function() {
            console.log('from self foo')
        },
        bar: function() {
            console.log('bar')
        },
        conflicting: function() {
            console.log('from self')
        }
    }
})
 
vm.foo()  // => 'from self foo'
vm.bar()  // => bar
vm.conflicting()  // => 'from self'
```
如上，`vm.foo()`调用的是组件对象自身的foo


## 全局混合
全局混合不推荐使用，具体查看参考部分的官方教程

## 自定义选项合并策略
查看官方教程了解

## 结论
混合可以让我们封装一些小的功能模块用于重复利用，当然，高阶组件也可以实现，具体使用哪种方式，根据实际情况进行考虑，避免滥用


## 参考: 
- [Using Mixins in Vue.js](https://css-tricks.com/using-mixins-vue-js/)
- [Vue 混合](https://cn.vuejs.org/v2/guide/mixins.html)