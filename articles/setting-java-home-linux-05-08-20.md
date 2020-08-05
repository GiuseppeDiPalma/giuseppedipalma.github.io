# Setting JAVA_HOME in linux

![](https://picsum.photos/800/300)

## The first guide is written only to test and set the guide structure of all articles.

The Java Home is the folder where the JAVA binaries are located and the relative path of all the useful libraries. This guide is useful for setting up java home for all users. 

After installing java, let's check the installation and the version:
```{.bash}
java -version
```

Next, find the JAVA installation folder, copy result path:
```bash
find /usr/lib/jvm/java-1.x.x-openjdk
```

Go in /etc/profile file and write this:
```bash
vi /etc/profile 

	export JAVA_HOME=/usr/java/jdk1.7.0
	export PATH=${JAVA_HOME}/bin:${PATH}
```

And give this as a command line
```bash
source /etc/profile
```

To check this procedure
```bash
echo $JAVA_HOME
```