# Dotfiles

<img src="http://stream1.gifsoup.com/view6/1949166/60s-computer-o.gif" alt="Dotfiles" align="right" width=300 />

This project is mainly for my benefit. There are no configuration options other
than those defined in the source.

## Installation
The installer doesn't do anything clever. It symlinks the project (excluding
things like `.git` and this README) into the home directory of the current
user. An error will be raised if the target already exists and isn't a symlink.

```bash
git clone --recursive https://github.com/adlawson/dotfiles.git &&\
cd dotfiles &&\
./install.sh
```

## License
While a license is pretty useless for this repository, I've included one for
completeness. The content of this library is released under the
**MIT License** by **Andrew Lawson**. You can find a copy of this license in
[`LICENSE`][license] or at http://www.opensource.org/licenses/mit.

[license]: LICENSE
