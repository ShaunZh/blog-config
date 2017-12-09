---
title: Vue-Nodejs搭建博客
date: 2017-10-01 11:36:39
categories:
tags: Vue
---
## Express安装
- `npm install express --save` 
- 使用Express生成器创建应用程序框架
  因为并未将express进行全局安装，所以需要在`node_modules`中找到`express-generator`，来生产框架
  `./node_modules/express-generator/bin/express-cli.js . -f -e`
  可以通过` ./node_modules/express-generator/bin/express-cli.js -h`来查看该命令的相关选项
- `npm install` 安装依赖
- `npm start` 启动网站，然后在浏览器中输入`localhost:3000`打开网站
  可以在`bin/www`中改变端口号
