## DVCS-Bash-Config ##

### Description ###

This my config for terminal session file `~/.bashrc`. Implemented git prompt highlight:

1. Git branch
2. Git branch dirty 

Looks like this:

![](https://dl.dropbox.com/u/14947871/pics/github/DVCS-highlight.png)

Implemented and tested on Ubuntu. I've made some changes in `.bashrc` to reach my goal:

1. Uncommented variable `force_color_prompt` (39th line) to enable bash prompt highlight
2. Created variable `git_highlight` (40th line) that indicate activity git prompt highlight
3. Created function `get_git_status()` (42nd line) that recognize git branch and git branch dirty
4. Added some branching (79th line) depending on value existing variables `force_color_prompt` and `git_highlight`

### Repository Content ###

    ./.bashrc                 Bash config (hidden)
    ./README.md               This file with markdown markup

### Usage ###

You can just replace your `~/.bashrc` file on my or use changes that explained above to reach more custom flexibility.
