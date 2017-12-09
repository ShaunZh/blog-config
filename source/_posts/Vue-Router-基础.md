---
title: Vue-Router-基础
date: 2017-09-27 10:51:40
categories:
tags: Vue-Router
---
## 基础
路由的使用需要在 **HTML**和 **JS**中进行处理
### HTML部分
HTML中主要需要处理 **路由的跳转** 和 **跳转后的显示**
**路由的跳转**
通过`<router-link></router-link>`来进行实现，可以将其理解为一个`<a></a>`标签
通过`to`来指定跳转的位置(其实就是组件)，
如: `<router-link to="/foo">Go to Foo</router-link>`

**跳转后的显示**
通过`<router-view></router-view>`来显示跳转后的内容(其实就是组件的内容)

完整的代码如下：
```html 
<div id="app">
    <p>
       <!-- to="/foo"：表示跳转到 "/foo" 的地址，而这个地址是与相应的组件绑定的 -->
        <router-link to="/foo">Go to Foo</router-link>
        <router-link to="/bar">Go to Bar</router-link>
    </p>
    <router-view></router-view>
</div>
```

### JS部分
简单点说，js部分主要是为相应的组件匹配地址，主要分为以下几个步骤进行：
- **创建组件**
  该组件就是进行路由跳转的组件，就是`Vue组件`
  如： `const Foo = { template: '<div>foo</div>' }`
  当然，组件也可以是通过`import`导入的
- **定义路由**
  每个路由映射一个组件，如：
  ```js 
        const routes = [
            {path: '/foo', component: Foo},
            {path: '/Bar', component: Bar}
        ]
  ```
  **path**: 表示的是路由地址
  **component**: 表示的是映射的组件

- **创建router实例，然后传入 `routes` 配置**
  ```js 
    const router = new VueRouter({
        routes: routes;
    })
  ```

- **将路由挂载到Vue根实例中**
  ```js 
    new Vue({
        el: '#app'
        router: router
    })
  ```

js部分主要包括以上四部分，完整代码：
**html部分**
```html
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<div id="app">
  <h1>Hello App!</h1>
  <p>
    <!-- 使用 router-link 组件来导航. -->
    <!-- 通过传入 `to` 属性指定链接. -->
    <!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
    <router-link to="/foo">Go to Foo</router-link>
    <router-link to="/bar">Go to Bar</router-link>
  </p>
  <!-- 路由出口 -->
  <!-- 路由匹配到的组件将渲染在这里 -->
  <router-view></router-view>
</div>
```
**js部分**
```js
// 0. 如果使用模块化机制编程，導入Vue和VueRouter，要调用 Vue.use(VueRouter)

// 1. 定义（路由）组件。
// 可以从其他文件 import 进来
const Foo = { template: '<div>foo</div>' }
const Bar = { template: '<div>bar</div>' }

// 2. 定义路由
// 每个路由应该映射一个组件。 其中"component" 可以是
// 通过 Vue.extend() 创建的组件构造器，
// 或者，只是一个组件配置对象。
// 我们晚点再讨论嵌套路由。
const routes = [
  { path: '/foo', component: Foo },
  { path: '/bar', component: Bar }
]

// 3. 创建 router 实例，然后传 `routes` 配置
// 你还可以传别的配置参数, 不过先这么简单着吧。
const router = new VueRouter({
  routes // （缩写）相当于 routes: routes
})

// 4. 创建和挂载根实例。
// 记得要通过 router 配置参数注入路由，
// 从而让整个应用都有路由功能
const app = new Vue({
  el: "#app",
  router: router
})

// 现在，应用已经启动了！

```
运行效果查看：[这里](http://output.jsbin.com/tecupi#/bar)

## 动态路由匹配
考虑这样一种场景：现在有一个用户信息界面，不同的用户，显示不同的个人信息，用户通过id来标识，虽然id不同，但是它们都是通过同一个用户信息组件进行显示，只不过填充了不同的内容，假设它们的地址为:`/user/:id`，这个地址根据id的不同，最终会产生不同的地址，这个便是 **动态路由**。

**官方解释：**我们经常需要将 **某种模式** 匹配到的所有路由，全部映射到 **同一个组件**上，例如，我们有一个 User 组件，对于所有 ID 各不相同的用户，都要使用这个组件来渲染。那么，我们可以在 vue-router 的路由路径中使用『动态路径参数』（dynamic segment）来达到这个效果：

```js
const User = {
    template: '<div>User</div>'
}

const router = new VueRouter({
    routes: [
    // 动态路由参数，以 冒号 开头
        {path: "/user/:id", component: User}
    ]
})
```
现在，`/user/foo`和`/user/bar`都将映射到相同的路由上

实例：
```html  
  <div id="app2">
    <h1>Hello router</h1>
    <p>
      <router-link to="/user/foo">Go to Foo</router-link>
      <router-link to="/user/bar">Go to Bar</router-link>
    </p>
    
    <router-view></router-view>
  </div>
```
```js 

var User = {
  template: '<div> 我的参数是：{{ $route.params.id }} </div>'
};

var router2 = new VueRouter({
  routes: [
    {path: '/user/:id', component: User}
  ]
})

new Vue({
  el: '#app2',
  router: router2
})
```

一个 **路径参数** 以 **冒号** 标记。当匹配到一个路由时，参数值会被设置到`this.$route.params`中，可以在每个组件内使用

**多段路径参数的配置**
可以在路径中设置多段 **路径参数**， 对应的值会设置到 `$route.params`中
|模式|路径参数|$route.params
|----|--------|--------------
|/user/:username|/user/evan/ `{username: evan}`
|/user/:username/post/:post_id|user/evan/post/123| `{username: evan, post_id: 123}`

除了`$route.params`外，`$route`对象还提供了其它有用的信息，例如：`$route.query`, `$route.hash` 等等，可以查看 [API 文档](https://router.vuejs.org/zh-cn/api/route-object.html)
**注意**：
- 动态路由是以 **冒号** 开头


## 响应路由参数 的变化
注意：当使用路由参数时，例如从`/user/foo`导航到`/user/bar`，**原来的组件会被复用**。因为两个路由渲染同一个组件，比起销毁再重建，更加高效。不过，**这也意味着组件的生命周期钩子不再被调用**。
实例：
```html  
  <div id="app2">
    <h1>Hello router</h1>
    <p>
      <router-link to="/user/foo">Go to Foo</router-link>
      <router-link to="/user/bar">Go to Bar</router-link>
    </p>
    
    <router-view></router-view>
  </div>
```
```js 

var User = {
  template: '<div> 我的参数是：{{ $route.params.id }} </div>',
  created: function() {
    console.log('a');       // 只会在第一次路由切换时被调用
  }
};

var router2 = new VueRouter({
  routes: [
    {path: '/user/:id', component: User}
  ]
})

new Vue({
  el: '#app2',
  router: router2
})
```
上面代码中的User组件里面的`created`钩子只会被调用一次，当再进行路由切换时，不会被调用，这也就说明了路由的切换是复用同一个组件

复用组件时，如果想要对 **路由参数的变化**做出响应的话，可以简单的通过`watch`监测`$route`对象的变化，如下：
```js 
 watch: {
    $route(to, from){
      console.log(to.path);
      console.log(from.path)
    }
  }
```

## 匹配优先级
有时候，同一个路径可以匹配多个路由，此时，匹配的优先级就按照路由的定义顺序：**谁先定义，谁的优先级就高**


## 代码
[实验代码](http://output.jsbin.com/tecupi#/user/posts)