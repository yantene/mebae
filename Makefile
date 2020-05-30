SOUND_FONT := /usr/share/soundfonts/FluidR3_GM.sf2
DEVICE_NUMBER := 1

.DEFAULT_GOAL := dist/song.flac

dist/song.mid: $(wildcard src/*.takt) $(wildcard src/*/*.takt)
	mkdir -p dist
	takt -o $@ src/song.takt

dist/song.flac: dist/song.mid
	fluidsynth -F $@ -T flac $(SOUND_FONT) $^

.PHONY: play
play: src/song.takt
	takt -m $(DEVICE_NUMBER) $^

.PHONY: interpret
interpret:
	takt -m $(DEVICE_NUMBER)
