---
title: Vue组件通信
date: 2017-09-25 23:01:15
categories:
tags: Vue
---
Vue组件通信大致可以分为三种情况：**父→子通信**、**子→父通信**和 **非父子组件通信**

## 父子通信
**父组件通过props传递数据到子组件**
代码如下：
```js 
Vue.component('child', {
  template: '<p>{{ message }}</p>',
  props: ['message']
});

```
父组件中使用子组件，通过props输数据到子组件
```js
<child message="hello"></child>
```

## 子组件向父组件传递数据
**通过`v-on`绑定自定义事件来实现**，每个Vue实例都实现了 **事件接口**，即：
- 使用`$on(eventName)`监听事件
- 使用`$emit(eventName)`触发事件

父组件可以在使用子组件的地方直接使用`v-on`来监听子组件触发的事件，**不能使用`$on`监听子组件触发的事件**

例子如下：

```js
// 子组件
Vue.component('button-counter', {
  template: '<button @click="incrementCounter">{{ counter }}</button>',
  data: function() {
    return {
        counter: 0
    }
  },
  methods: {
    incrementCounter: function() {
        this.counter += 1;
        // 触发 'increment' 事件
        this.$emit('increment');
    }
  }
});

new Vue({
    el: "#counter-event-example",
    data: {
        total: 0
    },
    methods: {
        incrementTotal: function() {
            this.total += 1;
        }
    }
})

// 父组件
<div id="counter-event-example">
    <p> {{ total }}</p>
    // 在父组件中通过 v-on 监听increment事件，当事件触发后，调用incrementTotal方法
    <button-counter v-on:increment="incrementTotal"></button-counter>
    <button-counter v-on:increment="incrementTotal"></button-counter>
</div>
```
上面代码实现的流程：子组件要往父组件 **主动**传递消息，那么必须在子组件中调用`$emit(eventName)`触发事件，然后在父组件上通过`v-on:eventName`监听事件，当父组件监听到数据后调用相应的方法响应子组件，这样便实现了子组件向父组件传递消息

参考: [使用v-on绑定自定义事件](https://cn.vuejs.org/v2/guide/components.html#使用-v-on-绑定自定义事件)

## 非父子组件通信
**原理**：通过定义一个公共的Vue实例，然后在该实例上绑定事件即可
代码如下：
```js
// 全局Vue实例，通过在该实例上绑定事件，
var box = new Vue();

// 子组件1
var childOne = {
    name: 'childOne',
    props: ['childMsg'],
    template: '<div v-text="childMsg" @click="commit" class="msg1"></div>',
    data: function() {
        return {
            msg: "component1"
        }
    },
    methods: {
        commit: function() {
            // 触发 'oneToTwo' 事件，并传递一个对象数据，childTwo订阅了该事件，因此会接收到
            box.$emit('oneToTwo', {
                msg: 'i am component1'
            });
        }
    },
    // 组件被挂载就定于twoToOne事件
    mounted() {
        // 订阅 'twoToOne' 事件，当twoToOne事件触发时，调用回调函数，twoToOne的触发事件会传递一个参数过来，将其存放在data中
        box.$on('twoToOne', (data) => {
            this.msg = data.msg
         })
    }
};

// 子组件2
var childTwo = {
    name: 'childTwo',
    props: ['childMsg'],
    template: '<div v-text="msg" @click="btnClick" class="msg2"></div>',
    data: function() {
        return {
            msg: 'component2'
        }
    },
    mounted() {
        bus.$on('oneToTwo', (data) => {
            this.msg = data.msg;
        })
    },
    methods: {
        btnClick: function() {
            this.$emit('twoToOne');
        }
    }
} 
```