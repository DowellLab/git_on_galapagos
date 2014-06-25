### Git on galapagos

__Creating a new repository called 'NewRepository' on galapagos__

After logging onto galapagos run the following:

```shell
cd /opt/git/
mkdir NewRepository.git
cd NewRepository.git
git --bare init
```

If the init worked correctly, it should output: `Initialized empty Git repository in /opt/git/NewRepository.git/`

Next, log out of galapagos and run the following on your local machine:

```shell
cd <path/to/your/code>
git init
git add <files>
git commit -m '<commit_message>'
git remote add galapagos <galapagos_username>@galapagos.colorado.edu:/opt/git/NewRepository.git
git push galapagos master
```

After prompting for your galapagos password, git should output a number of steps and finish with `* [new branch]      master -> master`

Now when you make changes to your files, you simply add the files you want to commit, commit the changes, and push to galapagos again:

```shell
git add <files>
git commit -m '<commit_message>'
git push galapagos master
```

Alternatively, you can commit all files that have been modified (and have already been added with 'git add') with:

```shell
git commit -a -m '<commit_message>'
git push galapagos master
```

That's it! That's enough to get you started, but there is much more on thorough documentation at  http://git-scm.com/book/en/Git-Basics. 

__Automatically mirroring to github.com__

In order to view the code and revisions on https://github.com, you can mirror your galapagos repository on the github servers. To start, you'll need a github account and an ssh public key on galapagos. If you don't already have an ssh public key on galapagos, you can follow directions in the __Adding a ssh public key to galapagos__ section.

First, you need to create a new repository on github.com. To do this, login to github and click the '+' icon in the upper right, select 'New repository' from the dropdown menu, and enter in the repository name. Click 'Create repository' when you're done.

Next, you need to clone the repository locally as a mirror. I recommend creating a separate directory to hold all of your mirrored repositories as that will help with the cron job later on. After changing into this new directory, type:

```shell
git clone --mirror <galapagos_username>@galapagos.colorado.edu:/opt/git/NewRepository.git
cd NewRepository.git
git remote set-url --push origin https://<github_username>:<github_password>@github.com/<github_username>/NewRepository.git
```

Note that there are two places in the command that you'll need to add your github username to the URL and one place that you'll need to add your github password. This will prevent later `push` commands from prompting for a username/password later on, which will simplify our final cron job.

Now whenever the repository on galapagos is updated, the changes can be pushed to github with:

```shell
git fetch -p origin
git push --mirror
```

Git does not have a mechanism in place to automatically update mirrors, but you can set up a cron job on your local machine to run the above two commands periodically. I created a generic shell script in this repository called `update_mirrors.sh` to do this for you.

Normally the `fetch` command prompts you for a username/password each time it is called, but by adding an ssh public key to galapagos, we bypass this prompt.

Place the `update_mirrors.sh` script in a permanent location for it to be run. On my mac, I generally use the `/usr/local/bin/` directory for permanent scripts. Next, open the script and simply change the `MIRROR_PATH` variable in the script to the directory that contains your mirrored repositories. The script will run the above two commands in every subdirectory of the `MIRROR_PATH` directory.

Next, open the cron job scheduler by typing:

```shell
env EDITOR=nano crontab -e
```

And add the `update_mirrors.sh` script by adding the line:

```shell
0 */2 * * * <path/to/script/>update_mirrors.sh
```

The `0 */2 * * *` before the script name indicates that the script should run every two hours. You can change this to whatever frequency you like, as described on http://en.wikipedia.org/wiki/Cron.

Now your local machine will automatically update the github repository to whatever frequency you set in the cron job!

__Adding an existing repository to galapagos__

Create a bare repository on local machine and push to galapagos:

```shell
git clone --bare ExistingRepository project.git
scp -r project.git <galapagos_username>@galapagos.colorado.edu:/opt/git
```

__Adding a ssh public key to galapagos__

Instructions

Note: you'll notice that when you ssh into galapagos from now on, it won't prompt you for a password anymore. This is due to your ssh public key!