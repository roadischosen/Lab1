lab1:
	gnatmake -d -gnat2012 -Plab1.gpr

lst:
	gcc -c src/*.adb -gnat2012 -gnatl=.lst
	@cat data.adb.lst lab1.adb.lst > lab1.lst
	@$(RM) *.o *.ali *.adb.lst

clean:
	$(RM) lab1 lab1.lst obj/*

run: lab1
	./lab1
