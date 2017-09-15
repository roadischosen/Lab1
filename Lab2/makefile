DIR = src

lab2: classes
	jar cfe lab2.jar Lab2 -C src/ .
	$(RM) $(DIR)/*.class

classes:
	javac -g $(DIR)/*.java

run: lab2
	java -jar lab2.jar

clean:
	$(RM) $(DIR)/*.class lab2.jar
