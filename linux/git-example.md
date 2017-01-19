Git Examples
=================================

### Modify/add files in an existing git repo
```
git add hbase.rest.scanner.filters.md
git commit -m "add commandline"
git push -u origin master
```

### Create a new git repo
```
echo # admincode >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/weipinghe/admincode.git
git push -u origin master
```

### Common errors
```
D:\mygit\admincode\hadoop > git push -u origin master
To https://github.com/weipinghe/admincode.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/weipinghe/admincode.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

D:\mygit\admincode\hadoop > git pull
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 3
Unpacking objects: 100% (3/3), done.
From https://github.com/weipinghe/admincode
    7  master     -> origin/master
Merge made by the 'recursive' strategy.
 mytitle | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 mytitle
 
D:\mygit\admincode\hadoop > git push -u origin master
Counting objects: 9, done.
Delta compression using up to 4 threads.
```