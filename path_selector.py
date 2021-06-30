#!/home/SERAPHIC/liuy/.linuxbrew/bin/python3

'''this script needs two external lib, install them with pip:
pip3 install python-Levenshtein
pip3 install fuzzywuzzy
'''

import sys
import os
import glob
import re
from fuzzywuzzy import fuzz

cur_path = os.path.abspath(os.curdir)
proj_mark = '/src'
proj_path = ""

pos = cur_path.find(proj_mark)
if pos != -1:
    proj_path = cur_path[:pos + len(proj_mark)]

def output_path(path):
    print(path)

if len(sys.argv) < 2:
    if len(proj_path) == 0:
        output_path(os.environ["HOME"])
    else:
        output_path(proj_path)
    exit(0)

def get_candidate_files(scan_dir):
    candidate_files = []
    for dir in scan_dir:
        this_path = os.path.expanduser(dir)
        for x in os.listdir(this_path):
            if x[0] == '.':
                continue
            file_path = os.path.join(this_path,x)
            if os.path.isdir(file_path):
                candidate_files.append(file_path)
    return candidate_files

def go_back(n):
    dst_path = cur_path
    for i in range(n):
        dst_path = os.path.join(dst_path,"..")
    output_path(dst_path)

key = sys.argv[1]
fuzz_dir = ["~/work", "~"]

'''
1. back with 'n.', n is a number
2. back with '...', dot number stand for level
'''
if key[-1] == "." and key[:-1].isdigit():
    go_back(int(key[:-1]))
    exit(0)

if key.count('.') == len(key):
    go_back(len(key))
    exit(0)


if key == "ls":
    for i in get_candidate_files(fuzz_dir):
        output_path(os.path.basename(i))
    exit(1)

# handle project relevant logic
proj_map = { "sf":"sraf/source/core" }
if len(proj_path) > 0:
    for k,v in proj_map.items():
        if key == k:
            dst_path = os.path.join(proj_path, v)
            output_path(dst_path)
            exit(0)
    path_pattern = ".*".join(key) + ".*"
    scan_list = []
    scan_list.append(cur_path)
    for i in get_candidate_files(scan_list):
        base_name = os.path.basename(i)
        match_obj = re.match(path_pattern, base_name)
        if match_obj != None:
            final_file = os.path.join(cur_path, match_obj.group(0))
            output_path(final_file)
            exit(0)

#fuzz match
match = [0, ""]
for path in get_candidate_files(fuzz_dir):
    file_name = os.path.basename(path)
    score = fuzz.ratio(file_name, key)
    if score > match[0]:
        match[0] = score
        match[1] = path

if match[0] != 0:
    src_list = glob.glob(os.path.join(match[1], "v*/src"))
    if len(src_list) != 0:
        output_path(src_list[0])
    else:
        output_path(match[1])
else:
    output_path("~")

