include libxputty/Build/Makefile.base

SUBDIR := MonoSpatializer

.PHONY: $(SUBDIR) libxputty  recurse

$(MAKECMDGOALS) recurse: $(SUBDIR)

clean:

libxputty:
	@exec $(MAKE) --no-print-directory -j 1 -C $@ $(MAKECMDGOALS)

$(SUBDIR): libxputty
	@exec $(MAKE) --no-print-directory -j 1 -C $@ $(MAKECMDGOALS)

