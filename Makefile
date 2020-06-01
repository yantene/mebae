SOUND_FONT := /usr/share/soundfonts/FluidR3_GM.sf2
DEVICE_NUMBER := 1

MP3_BITRATE := 320

.DEFAULT_GOAL := all

dist/song.mid: $(wildcard src/*.takt) $(wildcard src/*/*.takt)
	mkdir -p dist
	takt -o $@ src/song.takt

dist/song.wav: dist/song.mid
	fluidsynth -F $@ -T wav $(SOUND_FONT) $^

dist/song.flac: dist/song.wav
	flac -f -o $@ $^
	touch $@ # flac

dist/song.opus: dist/song.wav
	opusenc $^ $@

dist/song.mp3: dist/song.wav
	lame -b $(MP3_BITRATE) $^ $@

.PHONY: all
all: dist/song.flac dist/song.opus dist/song.mp3

.PHONY: play
play: src/song.takt
	takt -m $(DEVICE_NUMBER) $^

.PHONY: interpret
interpret:
	takt -m $(DEVICE_NUMBER)
