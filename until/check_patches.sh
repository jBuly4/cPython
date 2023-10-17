# скачиваем image c 7кой: docker pull centos:7
# запускаем контейнер и заходим: docker run -ti --rm -v ./to_container:/work_dir
# контейнер при выходе убьется (--rm), монтируем к нему мапочку с этим скрип
#!/bin/bash
set -x
set -e
yum clean al
yum install -y\
    git\
    make\
    gcc-c++\
    vim\
    ssh

git config --global user.email "jbuly4@jbuly4.jbuly4"
git config --global user.name "jbuly4"
cd cpython
rm -rf .git/rebase-apply/
git apply --check new_opcode.patch
git am --signoff < new_opcode.patch
./configure --with-pydebug --prefix=/tmp/python
make -j2
make install