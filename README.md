# Dotfiles

<img src="http://stream1.gifsoup.com/view6/1949166/60s-computer-o.gif" alt="Dotfiles" align="right" width=300 />

This project is mainly for my benefit. There are no configuration options other
than those defined in the source.

## Installation
The installer doesn't do anything clever. It `rsync`s the project (excluding
things like `.git` and this README) into the home directory of the current
user. You should be aware that any files that exist in the home directory may
be overwritten in the process.

```bash
git clone --recursive https://github.com/adlawson/dotfiles.git &&\
cd dotfiles &&\
./install
```
