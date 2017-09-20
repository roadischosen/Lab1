DIR = src

lab2.jar:
	javac -g $(DIR)/*.java
	jar cfe lab2.jar Lab2 -C src/ .
	@$(RM) $(DIR)/*.class

run: lab2.jar
	@java -jar lab2.jar

clean:
	$(RM) lab2.jar

re: clean lab2.jar
