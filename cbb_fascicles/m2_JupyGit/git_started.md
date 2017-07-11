# Lets Walk Through git

### Where to start

#### 1. Gitting help

```
$ git
```

-or-

```
$ git help
```

...will both gi(t)ve some help. We will git to many of these.

```
usage: git [--version] [--help] [-C <path>] [-c name=value]
	   [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
	   [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
	   [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
	   <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories togither
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept. 
```


#### 2. git your repository [started][setting up a repository]
**Surely, you have a directory with some code you would like to version
control, but lets start with some practice so nothing goes wrong. We 
will start by simulating an existing project, and git some practice in
terminal too.**

* **mkdir**: this will make a directory (this is basically a 'folder').

* **cd**: this will take you to (aka. change) a directory.

* **~/**: this is home :-).

* **touch**: this will make a file.

```
$ mkdir ~/path/thatistosay/location/you/want/to/git/practice/
$ cd ~/path/thatistosay/location/you/want/to/git/practice/
```

...now you will see

```
user at somewhere in ~/path/thatistosay/location/you/wnat/to/git/practice/
$ 
```

```
$ touch first_vercon_file.sofun
```
**You've made your first version controlled project, so fun! Lets version
contorl (g)it**.

* **git init**: initialize your git repository. This tells git to start paying
attention to this directory. Technically it puts a .git directory in your 
directory.

```
$ git init
```

...now you will see


```
$ git init
Initialized empty Git repositiory in ~/path/thatistosay/location/you/want/to/git/practice/
```

**Lets list what is in our repository**

* **ls -a**: ls (list) will show you the files in the directory. ls -a will show
you the 'hidden' or '.' files. 

```
$ ls 
```

...now you will see

```
$ ls
first_vercon_file.sofun
```

...but nothing has changed, still just that file there. We can ask ls to 
print more thouroughly with '-a'.

```
$ ls -a
.          ..        .git        first_vercon_file.sofun
```

the **-a** makes the list show the '.' files too. Now we can see the .git 
directory, so git should be tracking this directory. 

_FunFact: '.' and '..' are the directory you are currently in and the 
directory above it. Try_
```
$ cd ..
``` 
_and see what happens._

**Now git is in this directory, but you have not specified which files to
track. git does not track files until you explicitly tell it to:**

* **git status**: indicates what is staged for commit.

* **git add**: stages the content for the next commit. 

* **git commit**: stores the content and a message describing the current
state after your changes.

   _Warning: in this section we are using flags. Flags are simple, they alter
   the way a fuction operates. To learn about the flags of a function type:_
   ```
   $ man FUNCTION
   ```
   _Actually, you already used one 'ls -a', '-a' is a flag for ls.
   Flags are fun :-). press "q" to leave the man page_

```
$ git status
```

...now you see

```
On branch master

Initial commit

Untracked files:
(use "git add <file>..." to include in what will be committed)

   first_vercon_file.sofun

nothing added to commit but untracked files present (use "git add" to track)
```

Our file is not being tracked. Lets add it (using the most conservative
syntax).

```
$ git add -n first_vercon_file.sofun
```
...now we see
```
$ git add -n first_vercon_file.sofun
add 'first_vercon_file.sofun
```

Now that you have verified that this is the file you intended to add, add it.
```
$ git add first_vercon_file.sofun
```

...now we see

```
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   first_vercon_file.sofun
``` 
We are now ready to commit. '-m' will let you leave a message in line.

```
$ git commit -m 'project initial commit!'
```

wohooo!

```
$ git commit -m 'project initial commit!'
[master (root-commit) 22185a0] project initial commit!
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bleh.sofun
user at somewhere in ~/path/thatistosay/location/you/want/to/git/practice/ on master*
$
```

On master(whaa?), you now have your master branch, a  branch along your version
control tree. 

#### 3. git(ting) useful

**Now for some real world application: lets say you have your
analysis working, but you would like to add a new feature. git allows you to 
work on a script while keeping the working version in tact. We just need to
put our 'new development' on a different branc.**

* **git branch**: makes new branches, or lists current branches.

* **git checkout**: moves between branches, '-b' flag makes a new branch and
subsequently checks it out.

```
$ git branch developfeature
$ git checkout developfeature
```

-or-

```
$ git checkout -b developfeature
```

...will git you to the same place.

**Make some edits to your file, using the editor of your choice. I will use a
terminal editor 'vim'.**

* **vim**: terminal text editor, bare bones, very fast. If you are curious
and git stuck just hit 'esc' twice and type ':q!'. Want to [learn more about vim][google vim].

```
user at somewhere in ~/path/thatistosay/location/you/want/to/git/practice/ 
on developfeature*
$ vim ./first_vercon_file.sofun
```

**I added "some text." Litterally.**

* **git diff**: compare changes made against some standard.

```
$ git diff
diff --git a/first_vercon_file.sofun b/first_vercon_file.sofun
index numbers..numbers numbers 
--- a/first_vercon_file.sofun
+++ b/first_vercon_file.sofun
@@ -0,0 +1 @@
+some text
```

**Lets commit**

1. first do a **git status**
2. **git add** the 'untracked' files you want to stage for commit 
3. **git commit** your added files.
4. run a **git diff** and lean back like a git master.
```
git diff master developfeature
```

#### 4. visualize (g)it

**Now we can take a look at our tree and see where all our branches are, 
relative to one another**

* **git log**: lists the commit history of your repo. '--graph' shows a line
drawing of the relationship between commits (comes in handy when things git
complicated). '--decorate' tells us where each of our branches sit on the graph.

```
$ git log --graph --decorate
* commit numbersandletters (HEAD -> developfeature)
| Author: authorname <authoremail@stanford.edu>
| Date:  day month day# time
|
|     new feature
|
* commit numbersandletters (master)
  Author: authorname <authoremail@stanford.edu>
  Date:  day month day# time

      project initial commit!
```

#### 5. GitHub

**Lets git a [GitHub][setting up a GitHub account] account.**

[setting up a repository]: https://www.atlassian.com/git/tutorials/setting-up-a-repository

[google vim]: http://lmgtfy.com/?q=how+to+use+vim

[setting up a GitHub account]: http://bfy.tw/Cipo

