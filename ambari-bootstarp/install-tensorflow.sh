* INSTALLATION 
------------------------ 
sudo yum -y install epel-release
sudo yum -y install gcc gcc-c++ python-pip python-devel atlas atlas-devel gcc-gfortran openssl-devel libffi-devel
# use pip or pip3 as you prefer for python or python3
pip install --upgrade virtualenv
virtualenv --system-site-packages /opt/tensorflow
chmod -R 755 /opt/tensorflow
source /opt/tensorflow/bin/activate
pip install --upgrade numpy scipy wheel cryptography #optional
pip install --upgrade tensorflow



* USAGE
------------------------
source /opt/tensorflow/bin/activate
