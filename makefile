lab1:
	gnatmake -d -gnat2012 -PLab1/lab1.gpr

lab1.lst:
	rm -f lab1.lst
	gcc -c Lab1/src/*.adb -gnat2012 -gnatl=.lst
	cat data.adb.lst lab1.adb.lst > lab1.lst
	rm -f *.o *.ali *.adb.lst