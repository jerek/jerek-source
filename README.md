Jerek Source
============

A Bash script to source a series of shell scripts from organized subdirectories.

**Author:** Jerek Dain

**Email:** jerek@jerek.net

Installation
------------

    git clone git@github.com:jerek/jerek-source.git ~/.jereksource

Example Usage
-------------

Add the following two lines to your .bashrc:

    source ~/.jereksource/loader
    jerekSource 'env:local;tools:misc,git/common,vagrant;sites:main'

That would source:

    ~/.jereksource/autoload/*
    ~/.jereksource/env/local
    ~/.jereksource/tools/misc
    ~/.jereksource/tools/git/common
    ~/.jereksource/tools/vagrant
    ~/.jereksource/sites/main

Other Notes
-----------

Files in `~/.jereksource/autoload` will always be sourced, and sourced first.

Files to be sourced MUST exist at least 1 level within the directory holding the script. (`~/.jereksource` in the example usage above.)
