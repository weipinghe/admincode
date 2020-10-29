Compile TigerVNC Java Viewer
=================================
Need to build the jar file on a Linux machine.

```
1. Install jdk1.8, make, cmake
[root@localhost vnc]# rpm -qf /usr/bin/make
make-3.81-20.el6.x86_64

[root@localhost vnc]# rpm -qf /usr/bin/cmake
cmake-2.8.12.2-4.el6.x86_64

2. Set path and Java home
export JAVA_HOME=/usr/java/jdk1.8.0_271
export PATH=/usr/java/jdk1.8.0_271/bin:$PATH

3. cmake --target=VncViewer --build .

[root@localhost vnc]# cmake --target=VncViewer --build .
-- Found Java: /usr/java/jdk1.8.0_271/bin/java (found version "1.8.0.271")
-- Java compiler flags = -source 8 -target 8 -encoding UTF-8 -Xlint:all,-serial,-cast,-unchecked,-fallthrough,-dep-ann,-deprecation,-rawtypes
-- Configuring done
-- Generating done
-- Build files have been written to: /root/vnc

4. make

[root@localhost vnc]# make
Scanning dependencies of target java
[ 50%] Generating com/jcraft/jsch/DH.class,
com/jcraft/jsch/DHEC256.class,
com/jcraft/jsch/DHEC384.class,
com/jcraft/jsch/DHEC521.class,
com/jcraft/jsch/DHECN.class,
com/jcraft/jsch/DHGEX256.class,
com/jcraft/jsch/DHG1.class,
com/jcraft/jsch/DHG14.class,
com/jcraft/jsch/DHGEX.class,
com/jcraft/jsch/ECDH.class,
com/jcraft/jsch/JSch.class,
com/jcraft/jsch/Session.class,
com/jcraft/jsch/UserAuth.class,
com/jcraft/jsch/UserAuthKeyboardInteractive.class,
com/jcraft/jsch/UserAuthPassword.class,
com/jcraft/jsch/UserAuthPublicKey.class,
com/jcraft/jsch/UserAuthNone.class,
com/jcraft/jsch/jce/AES128CBC.class,
com/jcraft/jsch/jce/AES128CTR.class,
com/jcraft/jsch/jce/AES192CBC.class,
com/jcraft/jsch/jce/AES192CTR.class,
com/jcraft/jsch/jce/AES256CBC.class,
com/jcraft/jsch/jce/AES256CTR.class,
com/jcraft/jsch/jce/ARCFOUR.class,
com/jcraft/jsch/jce/ARCFOUR128.class,
com/jcraft/jsch/jce/ARCFOUR256.class,
com/jcraft/jsch/jce/BlowfishCBC.class,
com/jcraft/jsch/jce/DH.class,
com/jcraft/jsch/jce/ECDH256.class,
com/jcraft/jsch/jce/ECDH384.class,
com/jcraft/jsch/jce/ECDH521.class,
com/jcraft/jsch/jce/ECDHN.class,
com/jcraft/jsch/jce/HMAC.class,
com/jcraft/jsch/jce/HMACMD5.class,
com/jcraft/jsch/jce/HMACMD596.class,
com/jcraft/jsch/jce/HMACSHA1.class,
com/jcraft/jsch/jce/HMACSHA196.class,
com/jcraft/jsch/jce/HMACSHA256.class,
com/jcraft/jsch/jce/HMACSHA512.class,
com/jcraft/jsch/jce/KeyPairGenDSA.class,
com/jcraft/jsch/jce/KeyPairGenECDSA.class,
com/jcraft/jsch/jce/KeyPairGenRSA.class,
com/jcraft/jsch/jce/MD5.class,
com/jcraft/jsch/jce/PBKDF.class,
com/jcraft/jsch/jce/Random.class,
com/jcraft/jsch/jce/SHA1.class,
com/jcraft/jsch/jce/SHA256.class,
com/jcraft/jsch/jce/SHA384.class,
com/jcraft/jsch/jce/SHA512.class,
com/jcraft/jsch/jce/SignatureDSA.class,
com/jcraft/jsch/jce/SignatureECDSA.class,
com/jcraft/jsch/jce/SignatureRSA.class,
com/jcraft/jsch/jce/TripleDESCBC.class,
com/jcraft/jsch/jce/TripleDESCTR.class,
com/jcraft/jsch/jcraft/Compression.class,
com/jcraft/jsch/jcraft/HMAC.class,
com/jcraft/jsch/jcraft/HMACMD596.class,
com/jcraft/jsch/jcraft/HMACMD5.class,
com/jcraft/jsch/jcraft/HMACSHA196.class,
com/jcraft/jsch/jcraft/HMACSHA1.class
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
[100%] Generating VncViewer.jar

[root@localhost vnc]# pwd
/root/vnc
[root@localhost vnc]# ls
CMakeCache.txt  CMakeFiles  cmake_install.cmake  CMakeLists.txt com  Makefile  VncViewer.jar

[root@localhost vnc]# ls -l VncViewer.jar
-rw-r--r-- 1 root root 597131 Oct 27 12:30 VncViewer.jar

Copy to Windows machine, run under command prompt
D:\sharetmp>java -jar vncviewer.jar

TigerVNC Java Viewer v1.11.80 (20201027)
Built on 2020-10-27 at 19:30:16
Copyright (C) 1999-2020 TigerVNC Team and many others (see README.rst)
See https://www.tigervnc.org for information on TigerVNC.

```
Refer

https://github.com/TigerVNC/tigervnc/blob/master/BUILDING.txt

