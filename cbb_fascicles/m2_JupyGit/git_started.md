# Lets Walk Through git

### Where to start

##### 1. gitting help

  ```
  $ git
  ```

  **-or-**

  ```
  $ git help
  ```

  **...will both gitve**


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
	   merge      Join two or more development histories together
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

##### 2. git your repository [started][setting up a repository]
   **Surely you have a directory with some code you would like to version
   control, but lets start with some practice so nothing goes wrong. We 
   will start by simulating an existing project, and git some practice in
   terminal too.**
   
   * **mkdir**: this will make a directory (this is basically a 'folder')
   
   * **cd**: this will take you to (change) a directory 
   
   * **~/**: this is home :-)
  

   ```
   $ mkdir ~/path/thatistosay/location/you/want/to/git/practice/
   $ cd ~/path/thatistosay/location/you/want/to/git/practice/
   ```
   ...now you will see

   ```
   user at somewhere in ~/path/thatistosay/location/you/wnat/to/git/practice/
   $ 
   ```

   * **touch**: this will make a file 

   
   ```
   $ touch first_vercon_file.sofun
   ```
   **You've made your first version controlled project, so fun! Lets version
   contorl (g)it**
   
   * **git init**: initialize your git repository. This tells git to start paying
   attention to this directory.


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
   ...but nothing has changed, still just that file there.

   ```
   $ ls -a
   .          ..        .git        first_vercon_file.sofun
   ```

   the **-a** makes the list show the '.' files too. _FunFact: '.' and '..'
   are the directory you are currently in and the directory above it. Try_
   ```
   $ cd ..
   ``` 
   _and see what happens._

   **Now git is in this directory, but you have not specified which files to
   track. Git does not track files until you explicitly tell it to:**

   * **git status**: indicates what is staged for commit 
   * **git add**: stages the content for the next commit. 
   * **git commit**: stores the content and a message describing your changes.
   
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
   
   
    


[setting up a repository]: https://www.atlassian.com/git/tutorials/setting-up-a-repository


[setting up a GitHub account]: http://bfy.tw/Cipo
