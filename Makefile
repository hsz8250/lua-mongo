LUALIB=-I/usr/local/include -L/usr/local/bin -llua52
SOCKETLIB=-lws2_32

.PHONY: all win linux

all : 
	@echo Please do \'make PLATFORM\' where PLATFORM is one of these:
	@echo win linux

win: mongo.dll bson.dll md5.dll

linux: mongo.so bson.so md5.so

mongo.dll : lua-mongo.c lua-socket.c
	gcc --shared -Wall -g $^ -o$@ $(LUALIB) $(SOCKETLIB)

bson.dll : lua-bson.c
	gcc --shared -Wall -g $^ -o$@ $(LUALIB) $(SOCKETLIB)

md5.dll : lua-md5.c
	gcc --shared -Wall -g $^ -o$@ $(LUALIB) $(SOCKETLIB)

mongo.so : lua-mongo.c lua-socket.c
	gcc --shared -Wall -fPIC -g $^ -o$@ 

bson.so : lua-bson.c
	gcc --shared -Wall -fPIC -g $^ -o$@ 

md5.so : lua-md5.c
	gcc --shared -Wall -fPIC -g $^ -o$@ 

clean:
	rm -f mongo.dll bson.dll md5.dll mongo.so bson.so md5.so
