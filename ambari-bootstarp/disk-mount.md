data disks should be mounted directly 

- Use ext4 or xfs 

- The following commands are for ext4, use mordor for xfs

###
##LVM is fine on OS mount points, but not recommended for /grid/* that we typically use
##If you have /dev/sd[e-g] you should have them all formatted with xfs or ext4 and mounted direct like Olivier suggests
##LVM doesn't add anything except for overhead for these drives and we don't want a bunch of pv's pulled together as one volume, we want all the volumes formatted/mounted directly so we can deal more easily with individual drive failures
###


1 - Specify the formatting paramaters 

/etc/mke2fs.conf:
## add hadoop declaration to [fs_types] section
hadoop = {
  features = has_journal,extent,huge_file,flex_bg,\	
             uninit_bg,dir_nlink,extra_isize
  inode_ratio = 131072
  blocksize = -1
  reserved_ratio = 0
  default_mntopts = acl,user_xaddr
}


2 - Format the disk 

OPTION - 1 
server-path$: e2mkfs –t ext4 –T hadoop /dev/partition

#Sometimes, the e2mkfs is not avilable, so use mkfs
OPTION - 2 
server-path$: mkfs –t ext4 –T hadoop /dev/sdb

OPTION - 3 
mkfs.ext4 -T hadoop /dev/sdc1



# repeat this command for all drive. sd[b-g]



3 - Mount the filesystem 

mount /dev/sdb /grid/0 -o inode_readahead_blks=128,data=writeback,noatime,nodev,nobarrier

#repeat for all devices and mount points 
mount /dev/sd[b-g] /grid/[0-7] -o inode_readahead_blks=128,data=writeback,noatime,nodev,nobarrier



https://github.com/monolive/hadoop-lab/blob/master/kickstart/hadoop-ks.cfg





```
lsblk
sudo mkfs -t ext4 /dev/sdb1
sudo mkdir -p /grid/0
sudo mount -o rw,noatime,seclabel,attr2,inode64,logbsize=256k,sunit=512,swidth=1024,noquota,allocsize=128k,nobarrier,nodev /dev/sdb1 /grid/0
lsblk
mount


umount /grid/0
mkfs.xfs -f -l size=128m,lazy-count=1 -d su=512k,sw=6 -r extsize=256k /dev/sdb1
sudo mount -o rw,noatime,seclabel,attr2,inode64,logbsize=256k,sunit=512,swidth=1024,noquota,allocsize=128k,nobarrier,nodev /dev/sdb1 /grid/0
lsblk
mount


```
