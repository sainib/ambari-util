wget http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.0.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.0.0.0-453.tar.gz

ambari-server install-mpack \
--mpack=hdf-ambari-mpack-3.0.0.0-453.tar.gz \
--verbose
