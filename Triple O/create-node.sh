#!/bin/sh

rm -rf /var/lib/libvirt/images/oc-c*
sleep 5

qemu-img create -f qcow2 /var/lib/libvirt/images/oc-ctrl0.qcow2 100G
qemu-img create -f qcow2 /var/lib/libvirt/images/oc-cmpt0.qcow2 100G
qemu-img create -f qcow2 /var/lib/libvirt/images/oc-ceph0.qcow2 100G
qemu-img create -f qcow2 /var/lib/libvirt/images/oc-ceph1.qcow2 100G
#qemu-img create -f qcow2 /var/lib/libvirt/images/oc-ceph0-1.qcow2 100G
#qemu-img create -f qcow2 /var/lib/libvirt/images/oc-ceph0-2.qcow2 100G
#qemu-img create -f qcow2 /var/lib/libvirt/images/oc-ceph0-3.qcow2 100G

sleep 5
virt-install \
--name oc-ctrl0 \
--memory 8192 \
--cpu host,+svm \
--vcpus 8 \
--import \
--boot network,hd,menu=on \
--disk /var/lib/libvirt/images/oc-ctrl0.qcow2 \
--network bridge=br4,mac=52:54:81:00:a0:01 \
--network bridge=br0,mac=52:54:82:00:a0:01 \
--os-variant rhel7 \
--noautoconsole \
--noreboot

sleep 10
virt-install \
--name oc-cmpt0 \
--memory 8192 \
--cpu host,+svm \
--vcpus 8 \
--import \
--boot network,hd,menu=on \
--disk /var/lib/libvirt/images/oc-cmpt0.qcow2 \
--network bridge=br4,mac=52:54:81:01:a0:01 \
--os-variant rhel7 \
--noautoconsole \
--noreboot

sleep 10
virt-install \
--name oc-ceph0 \
--memory 4096 \
--vcpus 4 \
--import \
--boot network,hd,menu=on \
--disk /var/lib/libvirt/images/oc-ceph0.qcow2 \
--network bridge=br4,mac=52:54:81:02:a0:01 \
--noautoconsole \
--os-variant rhel7 \
--noreboot

sleep 10
virt-install \
--name oc-ceph1 \
--memory 4096 \
--vcpus 4 \
--import \
--boot network,hd,menu=on \
--disk /var/lib/libvirt/images/oc-ceph1.qcow2 \
--network bridge=br4,mac=52:54:81:02:a0:02 \
--noautoconsole \
--os-variant rhel7 \
--noreboot

#sleep 5
#virsh attach-disk oc-ceph0 /var/lib/libvirt/images/oc-ceph0-1.qcow2 vdb --current
#virsh attach-disk oc-ceph0 /var/lib/libvirt/images/oc-ceph0-2.qcow2 vdc --current
#virsh attach-disk oc-ceph0 /var/lib/libvirt/images/oc-ceph0-3.qcow2 vdd --current