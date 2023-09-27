#!/bin/bash
aliyun="registry.aliyuncs.com/google_containers"
k8sio="registry.k8s.io"
echo "getting kubeadm used images list"
kubeadm config images pull --image-repository "$aliyun"
# list all kubeadm needs images
for i in $(kubeadm config images list); do
    # get suffxi images name
	imagename=${i##*/}
    # concat new name
	aliimage="$aliyun/$imagename"
	echo "[rename] $aliimage >>>> $i"
    # rename registry to k8s.io
	ctr -n k8s.io i tag "$aliimage" "$i"
	echo "[remove] aliyun image $aliimage"
    # remove aliyun images
	ctr -n k8s.io i rm "$aliimage"
done;