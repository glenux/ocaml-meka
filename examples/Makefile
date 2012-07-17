#
# Example makefile for use with OCaml-Meka
#

# Program name
PROGRAMS=dow

# Program modules
dow_OBJS= \
	  GuiHttp \
	  Storage \
	  StorageFile \
	  StorageSqlite3 \
	  WikiHandler \
	  WikiHandlerEdit \
	  WikiHandlerView \
	  WikiEngine \
	  HttpTypes \
	  HttpRequest \
	  HttpAnswer \
	  HttpHandler \
	  Http \
	  Document \
	  Main

# local options to use for program
dow_INCS=-I +lablgtk2
dow_LIBS=unix threads lablgtk

# Global Ocaml options to use
OCAML_LIBS=
OCAML_INCS=
OCAML_OPTS=-w A -warn-error A -g -thread 

include OCaml.mk

