# CentOS TexLive Japanese
This repository contains:
- CentOS (latest)
- TeXLive (2020 full)
- Japanese font package (IPA)

# Useful command (add in `~/.bashrc`)
By adding the code below in `.bashrc`, you can create pdf file by only typing `tex2pdf [fname]` on your bash terminal. Note that no file extension included in `[fname]`, e.g. `tex2pdf texfile.tex` -> `tex2pdf texfile`.

```bash
tex2pdf () { 
    # using uplatex -> dvipdfmx 
    fname=$1 
    docker run --rm \ 
        -u "$(id -u $(whoami)):$(id -g $(whoami))" \ 
        -v $(pwd):/mnt/working \ 
        -v /etc/passwd:/etc/passwd:ro \ 
        -v /etc/group:/etc/group:ro \ 
        -v ${PWD}:/home \ 
        -it keith1994/centos-texlive-jp:latest \ 
        uplatex $fname.tex && dvipdfmx $fname.dvi 
} 
```
