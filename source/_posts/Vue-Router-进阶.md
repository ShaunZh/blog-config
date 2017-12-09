---
title: Vue-Router-进阶
date: 2017-09-27 17:40:12
categories:
tags: Vue-Router
---
## 导航钩子
导航钩子主要作用就是可以让我们跟踪导航跳转的每一个步骤，可以类比于Vue组件的钩子函数。
官方说明：`Vue-Router`提供的导航钩子主要用来 **拦截导航**，让它 **完成或取消**。 有多种方式可以在 **路由导航发生时**执行钩子：**全局的**、**单个路由独享的**，或者 **组件级的**。


### 导航的过程
一个导航的发生，主要经过如下步骤：
1. Navigation triggered (导航触发)
2. Call leave guards in deactive components (调用将要离开的路由组件上的`beforeRouteLeave`方法)
3. Call global **beforeEach** guards (调用全局钩子：`beforeEach`)
4. Call **beforeRouteUpdate** guards in reused components(2.2+) (如果跳转的是同一个组件上，也就是进行组件更新，那么就调用`beforeRouteUpdate`方法)
5. Call **beforeEnter** in **route config** (调用将要进入的路由对象中的`beforeEnter`方法)
6. Resolve async route components
7. Call **beforeRouteEnter** in activated components
8. Call global **beforeResolve** guards(2.5+)
9. Navigation confirmed.
10. Call global **afterEach** hooks.
11. DOM updates triggered.
12. Call callbacks passed to next in **beforeRouteEnter** guards with instantiated instances.

### 钩子类型
#### 全局钩子
- **beforeEach()**
- **afterEach()**
- **beforeResolve()**
这些钩子函数是在 `router`对象上使用的

#### 路由对象的钩子
- **beforeEnter()**
该钩子函数是在被定义的路由对象上使用的

#### 组件内的钩子
也就是说你可以在Vue组件内使用的路由钩子
- **beforeRouteEnter()**
- **beforeRouteUpdate()**
- **beforeRouteLeave()**

```js 
const Foo = {
  template: `...`,
  beforeRouteEnter (to, from, next) {
    // 在渲染该组件的对应路由被 confirm 前调用
    // 不！能！获取组件实例 `this`
    // 因为当钩子执行前，组件实例还没被创建
  },
  beforeRouteUpdate (to, from, next) {
    // 在当前路由改变，但是该组件被复用时调用
    // 举例来说，对于一个带有动态参数的路径 /foo/:id，在 /foo/1 和 /foo/2 之间跳转的时候，
    // 由于会渲染同样的 Foo 组件，因此组件实例会被复用。而这个钩子就会在这个情况下被调用。
    // 可以访问组件实例 `this`
  },
  beforeRouteLeave (to, from, next) {
    // 导航离开该组件的对应路由时调用
    // 可以访问组件实例 `this`
  }
}
```

需要注意的是：**`beforeRouteEnter`钩子不能访问`this`，因为钩子在导航确认前被调用，因此，因此即将登场的`新组件`还没有被创建**

不过，你可以通过传一个回调给 `next`来访问组件实例。在导航被确认的时候执行回调，并且把组件实例作为回调方法的参数。
```js 
beforeRouteEnter(to, from, next) {
    next(vm => {
        // 通过 `vm` 访问组件实例
    })
} 
```

**注意：**可以在`beforeRouteLeave`中直接访问`this`。该钩子通常用来**阻止用户在还没有保存修改前突然离开。可以通过`next(false)`来取消导航

### 实例代码
```html 
<div id="app">
  <h1>Vue的导航钩子</h1>
  <nav class="mainNav">
    <router-link :to="{ name: 'home'}">Home</router-link>
    
    <router-link :to="{ name: 'user', params: { userId: 123, userName: 'Test User 1'}}">User 123</router-link>
    
    <router-link :to="{ name: 'user', params: { userId: 456, userName: 'Test User 2'}}">User 456</router-link>
    
    <router-link :to="{ name: 'user', params: { userId: 789, userName: 'Test User3'}}">User 789</router-link>
    
    <router-link to="/bar">Bar</router-link>
    
    <router-link to="/foo">Foo</router-link>
    
    <router-link to="/error">Error</router-link>
  </nav>
  
  <section class="mainBody">
    <router-view></router-view>
  </section>
</div>
```

```css 
#app {
  max-width: 800px;
  margin: auto;
}

code {
  background: #f2f2f2;
  padding: 0 0.5rem;
}

.mainBody {
  border-top: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
  margin: 1rem 0;
  padding: 1rem 0;
}

nav.mainNav {
  > * {
    padding: 0 0.75rem;
    text-decoration: none;
  }
  
  > *:nth-last-child(n+2) {
    border-right: 1px solid #aaa;
  }
}
```

```js 
const Home = {
  template: `
    <section>This is the home screen.</section>
  `
} 

const Foo = {
  template: `
    <section>You will not see this template when Foo is redirected to Home.</section>
  `
} 

const Err = {
  template: `
    <section>
      You will not see this template. The error is passed to our error handler.
    </section>
  `
} 

const Bar = {
  template: `
    <section>
      <div>Bar</div>
    </section>
  `,
  beforeRouteEnter(to, from, next) {
    console.log('Entering Bar');
    
    next(vm => {
      vm.testFunc('Some Message');
      console.log('Fully Entered Bar')
    })
  },
  
  beforeRouteLeave( to, from, next) {
    console.log('leaving Bar');
    next()
  },
  methods: {
    testFunc(msg) {
      console.log(msg)
    }
  }
}

const User = {
  props: ['userId', 'userName'],
  template: `
    <div>
      User - {{userName}}({{userId}})
    </div>
  `,
  
  beforeRouteLeave( to, from, next) {
    console.log('Leaving User')
    next()
  },
  
  beforeRouteUpdate( to, from, next) {
    console.log('Reusing this component.')
    next()
  }
};

const routes = [
  {path: '/', name: 'home', component: Home},
  {path: '/bar', name: 'bar', component: Bar},
  {path: '/foo', name: 'foo', component: Foo},
  {path: '/error', name: 'error', component: Err},
  {
    path: '/user/:userId',
    name: 'user',
    component: User,
    props: true,
    beforeEnter: (to, from, next)=>{
      console.log('Entering User')
      next()
    }
  }
]

const router = new VueRouter({
  routes
})

router.beforeEach(( to, from , next) => {
  console.log('beforeEach')
  // re-route
  if (to.path === '/foo') {
    next('/')
  } else if (to.path === '/user/123') {
    next(false)
  } else if (to.path === '/error') {
    const err = new Error('My Error Message')
    next(err)
  } else {
    next()
  }
})

router.afterEach((to, from) => {
  console.log(`Just moved from '${from.path}' to '${to.path}' `)
})

router.beforeResolve(() => {
  console.log('beforeResolve')
})
router.onError(err => {
  console.log('Handing this error', err)
})

const app = new Vue({
  router 
}).$mount('#app')

```

**最主要的是理解导航的全过程，以及在各个阶段被调用钩子函数，再根据实际情况进行应用就可以了，类似于Vue组件的钩子函数(如：`created()`, `mounted()`等等)，其中`next()`方法非常重要，需要注意下**
 


### 参考
- [Vue Router Navigation Guards Explained](http://patrickwho.me/learn-vue-router-navigation-guards-quickly/)
- [Vue-Router 导航钩子](https://router.vuejs.org/zh-cn/advanced/navigation-guards.html)
[实验代码](http://js.jirengu.com/picuy/1#/)