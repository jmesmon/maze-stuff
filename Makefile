CFLAGS = -g -Wall -MMD -std=gnu99
LDFLAGS=

CC     = gcc
RM     = rm -rf
AR     = ar

MAKEFLAGS+="-R --no-print-directory"

ifndef V
	QUIET_CC   = @ echo '    ' CC $@;
	QUIET_LD   = @ echo '    ' LD $@;
	QUIET_AR   = @ echo '    ' AR $@;
	QUIET_LINK = @ echo '    ' LINK $@;
endif

.PHONY: all
all : maze-test

maze-test : gen_maze.o fastest_path.o
	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

maze-test : LDFLAGS += -lncurses

.PHONY: clean
clean :
	$(RM) *.[oda] maze-test

.SECONDARY:
%.o : %.c
	$(QUIET_CC)$(CC) $(CFLAGS) -c -o $@ $<

%.a   :
	$(QUIET_AR)$(AR) rcsD $@ $^

-include $(wildcard *.d)
