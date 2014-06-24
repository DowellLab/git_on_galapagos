### Git on galapagos

__Creating a new repository called 'NewRepository' on galapagos__

After logging onto galapagos run the following:
```
cd /opt/git/
mkdir NewRepository.git
cd NewRepository.git
git --bare init
```
If the init worked correctly, it should output: `Initialized empty Git repository in /opt/git/NewRepository.git/`

Next, log out of galapagos and run the following on your local machine:
```
cd <path/to/your/code>
git init
git add <files>
git commit -m '<commit_message>'
git remote add galapagos <username>@galapagos.colorado.edu:/opt/git/NewRepository.git
git push galapagos master
```
This should output a number of steps and finish with `* [new branch]      master -> master`

Now when you make changes to your files, you simply add the files you want to commit, commit the changes, and push to galapagos again:
```
git add <files>
git commit -m '<commit_message>'
git push galapagos master
```

Alternatively, you can commit all files that have been modified (and have already been added with 'git add') with:
```
git commit -a -m '<commit_message>'
git push galapagos master
```

That's it! That's enough to get you started, but there is much more on thorough documentation at  http://git-scm.com/book/en/Git-Basics . 

__Automatically mirroring to github.com__

In order to view the code and revisions on https://github.com , you can mirror your galapagos repository on the github servers. This is done with:
```
git push --mirror https://github.com/<github_username>/new-repository.git
```

You'll need a github account.

*****FINISH*****

__Adding an existing repository to galapagos__

Create a bare repository on local machine and push to galapagos:
```
git clone --bare ExistingRepository project.git
scp -r project.git <username>@galapagos.colorado.edu:/opt/git
```