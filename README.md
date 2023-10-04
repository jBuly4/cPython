# OTUS new_opcode
## Description
This patch is to optimize opcodes `LOAD_FAST` and `LOAD_CONST` into `LOAD_OTUS`.

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
cd work_dir/ && chmod +x check_patches.sh && ./check_patches
```
6. Go to python bin and start python3:
```bash
cd /tmp/python/bin/ && ./python3
```
7. Run this script
```python
def fib(n): return fib(n - 1) + fib(n - 2) if n > 1 else n 

import dis
dis.dis(fib)
```
# Results
If everything is done correctly then you should have this output:
```bash
1           0 LOAD_OTUS                1
              2 COMPARE_OP               4 (>)
              4 POP_JUMP_IF_FALSE       26
              6 LOAD_GLOBAL              0 (fib)
              8 LOAD_OTUS                1
             10 BINARY_SUBTRACT
             12 CALL_FUNCTION            1
             14 LOAD_GLOBAL              0 (fib)
             16 LOAD_OTUS                2
             18 BINARY_SUBTRACT
             20 CALL_FUNCTION            1
             22 BINARY_ADD
             24 RETURN_VALUE
        >>   26 LOAD_FAST                0 (n)
             28 RETURN_VALUE

```