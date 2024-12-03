# What does this repo contain?
This repo contains dotfiles managed using [chezmoi](https://www.chezmoi.io).

# Steps
We will be calling chezmoi, cz for ease of use.
## use these files on a new laptop
1. download cz
2. use:
    ```bash
    chezmoi init git@github.com:war-turtle/dotfiles.git
   # can use https url if ssh is not setup
   
   chezmoi apply
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

refer to [faqs](https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/) to read `How do I edit my dotfiles with chezmoi?`
