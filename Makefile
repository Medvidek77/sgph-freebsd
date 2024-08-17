VERSION = 0

PREFIX = /usr/local

all: sgph

util.o: util.c config.h util.h config.mk
	$(CC) $(CFLAGS) -O2 -pipe -c util.c -o util.o

main.o: main.c config.h util.h arg.h config.mk
	$(CC) -DVERSION=\"$(VERSION)\" $(CFLAGS) -O2 -pipe -c main.c -o main.o

sgph: main.o util.o
	$(CC) -o $@ -DVERSION=\"$(VERSION)\" $(CFLAGS) -O2 -pipe main.o util.o -s

config.h:
	cp config.def.h $@

clean:
	rm -rf sgph main.o 

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f sgph ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/sgph

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/sgph\
