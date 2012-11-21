.PHONY: clean distclean build launch

DSK=conway.dsk
LOADER=conway
SJASM=sjasmplus2


build: $(DSK)
launch: $(DSK)
	caprice --drivea=$^

%.o: %.z80
	$(SJASM) --sym=$@.sym $<

%.exo: %.o
	exomizer raw -o $@  -c $<

loader.o: conway.exo player.exo music.exo gfxintro.exo music_intro.exo

#gfxintro.exo: data/intro.scr
#	exomizer raw -o $@  -c $<


$(LOADER): loader.o 
	cp $^ $@

$(DSK): $(LOADER)
	test -e $@ || iDSK $@ -n
	iDSK $@ -f -i $^ -t 1 -e 7000 -c 7000

clean:
	-rm *.o *.exo

distclean:
	$(MAKE) clean
	-rm *.dsk



	

