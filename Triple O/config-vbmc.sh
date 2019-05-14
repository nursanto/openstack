#!/bin/sh

vbmc list

vbmc delete oc-ctrl0
vbmc delete oc-cmpt0
vbmc delete oc-ceph0
vbmc delete oc-ceph1

vbmc list

vbmc add oc-ctrl0 --port 7001 --username admin --password password --libvirt-uri qemu+ssh://root@192.168.26.11/system
vbmc add oc-cmpt0 --port 7002 --username admin --password password --libvirt-uri qemu+ssh://root@192.168.26.11/system
vbmc add oc-ceph0 --port 7003 --username admin --password password --libvirt-uri qemu+ssh://root@192.168.26.11/system
vbmc add oc-ceph1 --port 7004 --username admin --password password --libvirt-uri qemu+ssh://root@192.168.26.11/system

vbmc start oc-ctrl0
vbmc start oc-cmpt0
vbmc start oc-ceph0
vbmc start oc-ceph1

ipmitool -I lanplus -U admin -P password -H 127.0.0.1 -p 7001 power status
ipmitool -I lanplus -U admin -P password -H 127.0.0.1 -p 7002 power status
ipmitool -I lanplus -U admin -P password -H 127.0.0.1 -p 7003 power status
ipmitool -I lanplus -U admin -P password -H 127.0.0.1 -p 7004 power status

vbmc list
