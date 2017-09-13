lab1:
	gnatmake -d -gnat2012 -PLab1/lab1.gpr

lab1.lst:
	gcc -c Lab1/src/*.adb -gnatl=.lst
	cat data.adb.lst lab1.adb.lst > lab1.lst
	rm -f *.o *.ali *.adb.lst