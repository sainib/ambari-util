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
