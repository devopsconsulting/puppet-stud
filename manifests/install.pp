
# install the stud package. Note that this is not stud HEAD
# but a fork that has sane init.d functionality and a better
# config file syntax. Fork is at: https://github.com/bfg/stud.
# we hope this will get merged into HEAD soon so we can revert.
class stud::install {
    package {"stud":
        ensure => "0.3~0.2012061401",
    }
}