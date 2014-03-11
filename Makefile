
CC		:= dmd
INCLUDE	:= /usr/local/include
EXE		:= verex-example
OBJS	:= verex.o example.o

all: verex-example

verex-example: $(OBJS)
	$(CC) -of$(EXE) -I$(INCLUDE) $(OBJS)

%.o: %.d
	$(CC) -c -I$(INCLUDE) $<

.PHONY: clean

clean:
	rm *.o $(EXE)
