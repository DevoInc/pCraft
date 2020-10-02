# -*- coding: utf-8 -*                                                                                                                                                                                    
# Written by Sebastien Tricaud 2020

import os
import sys
import platform

from ctypes import *

from ami.bind import *

rundir = os.path.dirname(os.path.abspath(__file__))
os.environ["AMI_DATA_DIR"] = rundir

is_32bits = (sys.maxsize <= 2**32)
if is_32bits:
        raise ImportError("32 bits architectures not supported")

system = platform.system()

LOAD_LIB=""

if system == "Linux":
        LOAD_LIB=rundir + "/Linux/x86_64/libami.so"
if system == "Darwin":
        LOAD_LIB=rundir + "/Darwin/x86_64/libami.dylib"

#print(LOAD_LIB)                                                                                                                                                                                         
bind.library = cdll.LoadLibrary(LOAD_LIB)

