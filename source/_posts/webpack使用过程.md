---
title: webpack使用过程
date: 2017-09-28 16:45:47
categories:
tags: Webpack
---
## 加载scss文件 
webpack.config.js配置
```js 
module: {
    rules: [
      {
        test: /\.scss$/,
        //webpack 进行解析时，是从后往前进行解析，也就是先执行sass-loader
        use: ["style-loader", "css-loader", "sass-loader"]
      }
    ]
  },
```
需要安装：`npm i -D style-loader css-loader sass-loader node-sass`