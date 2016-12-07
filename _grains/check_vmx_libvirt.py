# -*- coding: utf-8 -*-
'''
Module for check vmx|svm  by python
'''

import commands

def check_whether_QEMU():
    grains = {}
    m = commands.getoutput("egrep -c '(vmx|svm)' /proc/cpuinfo")
    grains['check_kvm_status'] = m

    return grains
