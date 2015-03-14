TARGET_PLATFORM=c64
VICE_BASE=C:/Users/usucuha/retrocomputing/C64/WinVICE-2.4-x64
VICE_TARGET=$(VICE_BASE)/x64

CC65BASE=C:/Users/usucuha/retrocomputing/C64/cc65

CC=$(CC65BASE)/bin/cc65
CA=$(CC65BASE)/bin/ca65
LD=$(CC65BASE)/bin/ld65
CO=$(CC65BASE)/bin/co65

CURRDIR=$(shell pwd)

supcmbt: supcmbt.o text.o
	$(LD) -o supcmbt -t $(TARGET_PLATFORM) supcmbt.o text.o $(TARGET_PLATFORM).lib

supcmbt.o: supcmbt.c text.o
	$(CC) -O -t $(TARGET_PLATFORM) supcmbt.c
	$(CA) supcmbt.s

text.o: text.s
	$(CA) -t $(TARGET_PLATFORM) text.s

clean:
	rm -f *.o
	rm -f supcmbt
	rm -f supcmbt.s
	rm -f supcmbt.d64
	rm -f c64-hi.tgi

mkdisk: supcmbt
	rm -f supcmbt.d64
	cp $(CC65BASE)/tgi/c64-hi.tgi .
	$(VICE_BASE)/tools/c1541 -format supcmbt,1 d64 supcmbt.d64 8 -write supcmbt -write c64-hi.tgi

run: mkdisk
	$(VICE_TARGET) $(CURRDIR)/supcmbt.d64
