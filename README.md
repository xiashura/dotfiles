# The xiashura dotfiles

Settings for:
* i3wm (wm)
* nvim (text editor)
* ranger (file manager)
* kitty (terminal)
* oh-my-zsh (shell)
* picom (compositor)
* polybar (status bar)
* rofi (analog dmenu)
* pywal (color-schemes)
* dunst (notifications)

## auto save you config
this script do copy you config to .config folder and auto commit and push your git repository

### make dotfiles dir 
```
mkdir dotfiles && cd dotfiles 
```

### remote your git repository
```
git init
git branch -M master
git remote add origin https://github.com/exmaple/example.git
```
### download
```
curl https://github.com/xiashura/dotfiles/blob/master/auto.sh --output auto.sh
```
### set rule 
```
chmod u+x auto.sh
```

### create config and dir tmp
```
touch config && mkdir .config
```

### and set name config folder for save dotfiles
example:
```
i3
nvim
```
### uses 
```
./auto.sh
```

## screenshot

![](https://raw.githubusercontent.com/xiashura/dotfiles/master/1.png)

![](https://raw.githubusercontent.com/xiashura/dotfiles/master/3.png)

