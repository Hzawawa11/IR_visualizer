SRCS=	*.c
OBJS=	$(SRCS:.c=.o)
TARGET=	analyzer
FILE= test.c

CC=	gcc
CFLAGS=	-O2 -Wall
LDFLAGS=	-lncurses -lmenu

all:$(TARGET)

$(TARGET):$(OBJS)
	$(CC) -o $(TARGET)  $(OBJS) $(LDFLAGS) $(CFLAGS)

.c.o:
	$(CC) -c -O2 $<

debug:
	$(CC) -o $(TARGET)  -g $(SRCS) $(LDFLAGS) -O0

run:
	./$(TARGET)

clean:
	rm -f $(OBJS)	$(TARGET) *.ll

ir:
	$(CC) -emit-llvm -S -O0 -gline-tables-only $(SRCS)
