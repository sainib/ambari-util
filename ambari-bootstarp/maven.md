# Find the version of the latest Maven 
```
curl http://www.apache.org/dist/maven/maven-3/ 2>/dev/null | grep folder.gif | tail -1 | awk -F'"' '{ print $6 }'
```

# Install Maven 
```
cd /usr/local
wget http://www.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
sudo tar xzf apache-maven-3.5.2-bin.tar.gz
sudo ln -s apache-maven-3.5.2  maven
```
Add following lines -  
sudo vi /etc/profile.d/maven.sh
```
export M2_HOME=/usr/local/maven
export PATH=${M2_HOME}/bin:${PATH}
```

Continue 
```
source /etc/profile.d/maven.sh
```
