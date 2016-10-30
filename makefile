CC:=gcc
#CCFLAGS:=-Wall -Iinclude
CCFLAGS:=-Iinclude
CCFLAGS2:=-I/usr/local/Cellar/openssl/1.0.2h_1/include
CCFLAGS3:=-L/usr/local/Cellar/openssl/1.0.2h_1/lib
BIN:=bin
OPT:=-lssl -lcrypto

all: client ftpd print_server

libs:=lib/utils.c lib/zlog.c lib/vars.c

ftpd:server.c ${libs} $(BIN)
	${CC} ${CCFLAGS} ${CCFLAGS2} ${CCFLAGS3} -o./${BIN}/$@ server.c ${OPT} ${libs}

client:client.c ${libs} $(BIN)
	${CC} ${CCFLAGS} -o./${BIN}/$@ client.c ${libs}

print_server:test/print_server.c ${libs} $(BIN)
	${CC} ${CCFLAGS} -o./${BIN}/$@ test/print_server.c ${libs}

$(BIN):
	if [ ! -d /tmp/bin ]; then mkdir /tmp/bin; fi
	ln -s /tmp/bin bin

clean:
	rm ./${BIN}/*.o
	rm ./${BIN}/ftp*
	rm ./${BIN}/print_server
