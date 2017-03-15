# Dotfiles

<img src="http://stream1.gifsoup.com/view6/1949166/60s-computer-o.gif" alt="Dotfiles" align="right" width=300 />

This project is mainly for my benefit. There are no configuration options other
than those defined in the source.

Files installed with this library will be marked `This file is managed by
adlawson/dotfiles` to make them easily recognisable as files that will any lose
changes upon installation.

## Installation
The installer doesn't do anything clever. It `rsync`s the project (excluding
things like `.git` and this README) into the home directory of the current
user. You should be aware that any files that exist in the home directory may
be overwritten in the process.

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
