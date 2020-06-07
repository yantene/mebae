SOUND_FONT := /usr/share/soundfonts/FluidR3_GM.sf2
DEVICE_NUMBER := 1

MP3_BITRATE := 192

.DEFAULT_GOAL := all

dist/song.mid: $(wildcard src/*.takt) $(wildcard src/*/*.takt)
	mkdir -p dist
	takt -o $@ src/song.takt

dist/song.wav: dist/song.mid
	fluidsynth -F $@ -T wav $(SOUND_FONT) $^

dist/song.flac: dist/song.wav src/tags.txt
	flac \
		--tag=TITLE='$(shell grep -oP '(?<=^title ).*$$' $(lastword $^))'\
		--tag=ARTIST='$(shell grep -oP '(?<=^artist ).*$$' $(lastword $^))'\
		--tag=ALBUM='$(shell grep -oP '(?<=^album ).*$$' $(lastword $^))'\
		-f -o $@ $(firstword $^)
	touch $@ # flac

dist/song.opus: dist/song.wav src/tags.txt
	opusenc \
		--comment=TITLE='$(shell grep -oP '(?<=^title ).*$$' $(lastword $^))'\
		--comment=ARTIST='$(shell grep -oP '(?<=^artist ).*$$' $(lastword $^))'\
		--comment=ALBUM='$(shell grep -oP '(?<=^album ).*$$' $(lastword $^))'\
		$(firstword $^) $@

dist/song.mp3: dist/song.wav src/tags.txt
	lame \
		--tt '$(shell grep -oP '(?<=^title ).*$$' $(lastword $^))'\
		--ta '$(shell grep -oP '(?<=^artist ).*$$' $(lastword $^))'\
		--tl '$(shell grep -oP '(?<=^album ).*$$' $(lastword $^))'\
		-b $(MP3_BITRATE) $(firstword $^) $@

.PHONY: all
all: dist/song.flac dist/song.opus dist/song.mp3

.PHONY: play
play: src/song.takt
	takt -m $(DEVICE_NUMBER) $^

.PHONY: interpret
interpret:
	takt -m $(DEVICE_NUMBER)
