FROM centos 
RUN yum update 
RUN yum install -y \ 
    curl \ 
    fontconfig \ 
    git \ 
    less \ 
    perl-Digest-MD5 \ 
    unzip \ 
    vim \ 
    wget 
 
WORKDIR /home 
# install TexLive 
RUN wget http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz 
RUN tar xvf install-tl-unx.tar.gz 
RUN echo I | ./install-tl-20200623/install-tl -no-gui 
# install IPA fonts 
RUN mkdir -p /usr/share/fonts/japanese ;\ 
    mkdir -p /usr/share/fonts/japanese/TrueType 
RUN wget https://ja.osdn.net/projects/ipafonts/downloads/51868/IPAfont00303.zip ;\ 
    wget https://ja.osdn.net/projects/ipafonts/downloads/57330/IPAexfont00201.zip 
RUN unzip IPAfont00303.zip ;\ 
    unzip IPAexfont00201 
RUN mv IPAfont00303/*.ttf /usr/share/fonts/japanese/TrueType ;\ 
    mv IPAexfont00201/*.ttf /usr/share/fonts/japanese/TrueType 
RUN fc-cache -fv 
RUN /usr/local/texlive/2020/bin/x86_64-linux/tlmgr path add 
 
# add user 
ARG UID=1000 
RUN useradd -m -u ${UID} docker 
 
USER ${UID} 
 
# Docker run command in .bashrc 
# uplatex (Docker) 
#tex2pdf () { 
#    # using uplatex -> dvipdfmx 
#    fname=$1 
#    docker run --rm \ 
#        -u "$(id -u $(whoami)):$(id -g $(whoami))" \ 
#        -v $(pwd):/mnt/working \ 
#        -v /etc/passwd:/etc/passwd:ro \ 
#        -v /etc/group:/etc/group:ro \ 
#        -v ${PWD}:/home \ 
#        keith1994/centos-texlive-jp:latest \ 
#        /bin/bash -c "uplatex -synctex=1 $fname.tex 1> /dev/null && dvipdfmx $fname.dvi"
#}                                                                                     
