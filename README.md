# shautomate

This repository contains a very simple bash command line tool for setting up autosaves for git. You have to manually run the initialization command using `shautomate -i` and manually add any directories you would like to be tracked for autosaving with `shautomate -a .`. This is so that you don't start creating branches and commits in git repositories you don't intend to. Once initialized with repositories added, the package should run autosaves every 30 minutes, only saving if a repository has been modified since the last autosave. If you want to run a "quicksave" that simply does the autosave manually, you can manually call `shautomate -r`.

Autosaves commit all changes and files off of your working branch, whether untracked or tracked. This means autosave will form messy superpositions of different branches you're working off of if you work off multiple branches a lot. I would recommend only using autosave in the situation you have one development branch you are working off of that you want to make autosaves of files you have periodically without actually commiting any of your changes to the dev branch.

# Installation

Currently shautomate is only released as a .deb package, meaning it only works on linux distributions and requires dpkg to be installed.

To install, go to releases and download the latest release. Then you can run

```
sudo dpkg -i shautomate_0.3.deb
```

to install shautomate.

# Usage

To initialize for the first time, run 

```
shautomate -i
```

This will create a crontab job. If you want to remove the crontab job later for any reason, you can run
`crontab -e` and delete the job.

To add a directory to be tracked for autosaving:

```
shautomate -a $(pwd)
```

To remove a directory and stop tracking it for autosaving:
```
shautomate -x $(pwd)
```

And to manually run a quick save, run:

```
shautomate -r
```

# TODO

1. Add an option to configure shautomate to zip repositories and upload to an ftp server, giving users a simpler non-git option to autosave for any folder.
