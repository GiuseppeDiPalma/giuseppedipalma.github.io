# Setting JAVA_HOME in linux

## The first guide is written only to test and set the guide structure of all articles.

![](https://picsum.photos/800/300)

The Java Home is the folder where the JAVA binaries are located and the relative path of all the useful libraries. This guide is useful for setting up java home for all users. 

After installing java, let's check the installation and the version:


###### `Test`

```
java -version

java -version

java -version
```
###### `Test`
~~~
java -version2
java -version2
java -version2
~~~

~~~python
print("Hello, world!")
~~~

Next, find the JAVA installation folder, copy result path:
```
find /usr/lib/jvm/java-1.x.x-openjdk
```

Go in /etc/profile file and write this:
```
vi /etc/profile 

	export JAVA_HOME=/usr/java/jdk1.7.0
	export PATH=${JAVA_HOME}/bin:${PATH}
```

And give this as a command line
```bash
#!/bin/bash
function greeting() {

str="Hello, $name"
echo $str

}

echo "Enter your name"
read name

val=$(greeting)
echo "Return value of the function is $val"
```

To check this procedure
```bash
echo $JAVA_HOME
```