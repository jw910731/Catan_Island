CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDLIBS = -lm
# LDFLAGS = -L./library -I./library

SRCDIR = src
OBJDIR := $(shell [ -d obj ] || mkdir obj && echo "obj")
SRC=$(notdir $(wildcard $(SRCDIR)/*.c))

.PHONY: clean
clean:
	rm -rf Catan $(OBJDIR)

all: Catan

Catan: $(patsubst %.c, $(OBJDIR)/%.o, $(SRC))
	$(CC) $(CFLAGS) $(filter %.o, $^) -o $@ $(LDLIBS)

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(OBJDIR)/%.d
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJDIR)/%.d: $(SRCDIR)/%.c
	$(CC) -MT $(@:.d=.o) -MM -MP -o $@ $(CFLAGS) $<

.PRECIOUS: $(OBJDIR)/%.d
-include $(patsubst %.c, $(OBJDIR)/%.d, $(SRC))
