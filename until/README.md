# OTUS until statement
## Description
This patch is to add until in Python.
If you want to create patch: 
- clone repo with Python
- create new branch
- add changes to files
- commit changes
- run this command
```bash
git format-patch OLD_MAIN_BRANCH_NAME --stdout > YOUR_PATCH_NAME.patch
```

# Installation steps
0. Create project directory (lets it be ROOT_DIR)
```bash
cd ROOT_DIR
```
1. Get source of python
```bash
git clone -b 3.7 --single-branch https://github.com/python/cpython.git
```
2. Copy new_opcode.patch from this repo to cpython/ (ADD YOUR NAME AND EMAIL instead of mine)
3. Copy check_patches.sh to ROOT_DIR

After this step you should have this structure:
- ROOT_DIR/
  - cpython/
    - ...
    - new_opcode.patch 
  - check_patches.sh

4. Run docker
```bash
docker run -ti --rm -v .:/work_dir --name test_python_1 centos:7 /bin/bash
```
5. Execute:
```bash
cd work_dir/ && chmod +x check_patches.sh && ./check_patches.sh
```
6. Go to python bin and start python3:
```bash
cd /tmp/python/bin/ && ./python3
```
7. Run this script
```python
import dis

def myfoo(num):
    until num == 0:
        print(num)
        num -= 1

dis.dis(myfoo)
```
# Results
If everything is done correctly then you should have this output:
```bash
  2           0 SETUP_LOOP              20 (to 22)
        >>    2 LOAD_FAST                0 (num)
              4 LOAD_CONST               1 (0)
              6 COMPARE_OP               2 (==)
              8 POP_JUMP_IF_TRUE        20

  3          10 LOAD_GLOBAL              0 (print)
             12 LOAD_FAST                0 (num)
             14 CALL_FUNCTION            1
             16 POP_TOP
             18 JUMP_ABSOLUTE            2
        >>   20 POP_BLOCK
        >>   22 LOAD_CONST               0 (None)
             24 RETURN_VALUE
```