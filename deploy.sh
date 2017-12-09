hexo generate
cp -R public/* .deploy/shaunzh.github.io
cd .deploy/shaunzh.github.io
git add .
git commit -m "update"
git push origin master
