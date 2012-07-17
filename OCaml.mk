#
# Ocaml Makefile v0.3
#
# Author: Glenn Y. Rolland
#


MLI=$(wildcard *.mli)
ML=$(wildcard *.ml)
MLL=$(wildcard *.mll)
MLY=$(wildcard *.mly)

CMI=$(patsubst %.mli,%.cmi,$(MLI))
CMO=$(patsubst %.ml,%.cmo,$(ML))
CMX=$(patsubst %.ml,%.cmx,$(ML))

OCAMLLEX=ocamllex
OCAMLYACC=ocamlyacc
OCAMLDEP=ocamldep
OCAMLOPT=ocamlopt
OCAMLC=ocamlc

OCAML_OPTS+=
OCAML_INCS+=
OCAML_LIBS+=
## BYTECODE MODE
ifdef BC
else
endif

## VERBOSE MODE
ifdef V
I=
Q=
else
I=@\#
Q=@
endif

define PROGRAM_template
ALL_OBJS   += $($(1)_OBJS)
$(1): $$($(1)_OBJS:=.cmx)
	@printf "\033[31;1m"
	@echo "[L] $(1)"
	@printf "\033[0m"
	$(Q)$(OCAMLOPT) $($(1)_OCAML_OPTS) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) $($(1)_OCAML_INCS) $($(1)_OCAML_LIBS:=.cmxa) $($(1)_OBJS:=.cmx) -o $(1)
endef

$(foreach prog,$(PROGRAMS),$(eval $(call PROGRAM_template,$(prog))))

.PHONY: all
all: $(PROGRAMS)

.PHONY: doc
doc: 
	ocamldoc $(OCAML_INCS) -d doc -html $(ML) $(MLI)

%.ml: %.mll
	@echo -n -e "\x1B[31;1m"
	@echo "[MLL > ML] $<"
	@echo -n -e "\x1B[0m"
	$(OCAMLLEX) $(OCAMLLEX_OPTS) $(OCAML_INCS) $(OCAML_LIBS) $<
	$(I)echo ""

%.mli %.ml: %.mly
	@echo -n -e "\x1B[31;1m"
	@echo "[MLY > MLI ML] $<"
	@echo -n -e "\x1B[0m"
	$(Q)$(OCAMLYACC) $(OCAMLYACC_OPTS) $(OCAML_INCS) $(OCAML_LIBS) $<
	$(I)echo ""

%.cmi: %.mli
	@printf "\033[31;1m"
	@echo "[I] $<"
	@printf "\033[0m"
	$(I)$(OCAMLOPT) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -i $<
	$(Q)$(OCAMLOPT) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -c $<
	$(I)echo ""

%.cmx: %.ml
	@printf "\033[31;1m"
	@echo "[C] $<"
	@printf "\033[0m"
	$(I)$(OCAMLOPT) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -i $<
	$(Q)$(OCAMLOPT) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -c $<
	$(I)echo ""

%.cmo %.cmi: %.ml %.cmi %.mli
	@echo "[O] $<"
	$(I)$(OCAMLC) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -i $<
	$(Q)$(OCAMLC) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -c $<
	$(I)echo ""

%.cmo %.cmi: %.ml
	@printf "\033[31;1m"
	@echo "[O] $<"
	@printf "\033[0m"
	$(I)$(OCAMLC) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -i $<
	$(Q)$(OCAMLC) $(OCAML_OPTS) $(OCAML_INCS) $(OCAML_LIBS) -c $<
	$(I)echo ""

.PHONY: realclean
realclean: clean
	$(Q)rm -f $(patsubst %.mll,%.ml,$(MLL)) $(patsubst %.mly,%.mli,$(MLY)) $(patsubst %.mly,%.ml,$(MLY)) 

.PHONY: clean
clean:
	$(Q)rm -f $(PROGRAMS) *~ *.cm* *.o *.a *.so .depend *.cmxa *.cma

.depend: $(ML) $(MLI)
	$(Q)$(OCAMLDEP) $(ML) $(MLI) > .depend
	$(I)echo ""


.SUFFIXES:

-include .depend


