#!/usr/bin/env python
#
# load xinput custom settings

from os import environ
import subprocess

CONFIG_FILE= environ.get('HOME') + "/.config/dk/xinput"

if __name__=="__main__" :
    with open(CONFIG_FILE) as xinput_config:
        for comm in xinput_config.readlines():
            subprocess.run("xinput %s" % comm, shell=True)
