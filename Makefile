JFLAGS = -g -d .
JC = javac
.SUFFIXES: .java .class

# .java:
# 	$(JC) $(FLAGS) $<
.java.class:
	$(JC) $(JFLAGS) $<

CLASSES = \
	Parse/*.java

default: all

cup:
	javac -d . .\java_cup\Main.java 
cupc:
	java -cp .;.\java_cup java_cup.Main -package Parse -parser Grm Parse\Grm.cup
	copy /y Grm.java Parse\Grm.java
	copy /y sym.java Parse\sym.java
	del Grm.java
	del sym.java
lex:
	javac -d . .\JLex\Main.java
lexc: .\JLex\Main.java
	java JLex.Main Parse\miniC.lex
	copy /y Parse\miniC.lex.java Parse\Yylex.java
	del Parse\miniC.lex.java
all: lexc cupc
	$(JC) $(JFLAGS) $(CLASSES)

clean:
	del /r /f Parse/*.class