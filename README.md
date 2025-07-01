# What does this repo contain?
This repo contains dotfiles managed using [chezmoi](https://www.chezmoi.io).

# Steps
We will be calling chezmoi, cz for ease of use.

Note: `cz` is an alias for `chezmoi` command

## use these files on a new laptop
1. download cz
2. use:
    ```bash
    chezmoi init git@github.com:war-turtle/dotfiles.git
   # can use https url if ssh is not setup
   
   chezmoi apply
    ```

## How to update all your dotfiles
To update all you dotfiles with changes from github repo, do the following
```bash
cz cd
git pull origin main
cz diff # to view what changes will be applied
cz -v apply # to write the changes download from github to your dotfiles
    # -v is verbose flag
```

## To add a new file/directory to cz
```bash
cz add <path-to-file/directory>
cz cd
git add .
git commit -m "<commit-msg>"
git push origin main
cz -v apply
```

## make changes to a file managed by cz
```bash
chezmoi edit ~/.zshrc
chezmoi apply
```

If the file(let's take ~/.zshrc file for example) is already edited by some other program.
you can use
```bash
chezmoi diff # to view the difference

chezmoi merge ~/.zshrc
```
In the opened vs code window, local files are on the left and files from github are on the right

you can also use merge-all to merge all the file once instead of doing it one by one
```bash
cz merge-all
```

If you decide to do merges one by one and want to check which all files changed use:
```bash
cz diff | grep '^+++ '
```

refer to [faqs](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/) to read `How do I edit my dotfiles with chezmoi?`
