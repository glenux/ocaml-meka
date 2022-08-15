:rotating_light: **The project has moved to a self-hosted git instance!**<br/>
:rotating_light: **Please use the new URL for an up-to-date version:** https://code.apps.glenux.net/glenux/ocaml-meka


ocaml-meka
==========

A handy Makefile for OCaml projects

Usage example : 

    # list of created binaries
    PROGRAMS=dow
  
    # program-specific list of objects
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
    
    # program-specific includes
    dow_INCS=-I +lablgtk2
    
    # program-specific libraries
    dow_LIBS=unix threads lablgtk
  
    # global options (used for everything in PROGRAMS)
    OPTS=-w A -warn-error A -g -thread 
    
    # The most important line ;-)
    include OCaml.mk
