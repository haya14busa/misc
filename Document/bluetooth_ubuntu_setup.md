bluetooth_ubuntu_setup
=====

- [BluetoothSetup - Community Ubuntu Documentation](https://help.ubuntu.com/community/BluetoothSetup)

~~~
hcitool dev
sudo hidd --search
dmesg | tail
 -> 00:26:5e:93:1e:1b

bluez-test-device -i 00:26:5e:93:1e:1b list
 -> 00:1F:20:76:47:F3
bluez-test-device -i 00:26:5e:93:1e:1b trusted 00:1F:20:76:47:F3 yes
~~~

> sudo apt-get install libnss-myhostname

> [[ubuntu] 13.04 dmesg: Warning: nss-myhostname is not installed](http://ubuntuforums.org/showthread.php?t=2148342)

