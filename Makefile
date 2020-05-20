MAXSTATES := 10

MD := report.md

MCRL2 := \
    Cm.mcrl2 \
    Ctm.mcrl2 \
    buffers.mcrl2 \
    queue.mcrl2 \
    simple_c.mcrl2 \

PDF := $(MD:.md=.pdf)
LTS := $(MCRL2:.mcrl2=.lts)
LPS := $(MCRL2:.mcrl2=.lps)

DEPS := $(MD) $(MCRL2)
TARGS := $(PDF) $(LTS) $(LPS)

ALL := $(DEPS) $(TARGS)

all: $(ALL)

report.md: lpsxsim0.png lpsxsim10.png lpsxsim1.png ltsgraph_contador.png ltsview0.png ltsview10.png ltsview3.png temporalProperties.png

%.lps: %.mcrl2
	mcrl22lps $< $@

Ctm.lts: Ctm.lps
	lps2lts -l $(MAXSTATES) Ctm.lps Ctm.lts

%.lts: %.lps
	lps2lts $< $@

%.pdf: %.md
	pandoc -s -f markdown -t latex $< -o $@

watch:
	ls -1 $(DEPS) | entr -c make

clean:
	$(RM) $(TARGS)

.PHONY: all clean watch
