# Mebae

Social Composing with [Takt](http://takt.sourceforge.net/)!

## How to generate audio file (midi, wav, flac, opus and mp3!)

### Arch Linux

Install dependencies.

```
yay -S make takt fluidsynth soundfont-fluid flac opus-tools lame
```

```
make # when you want all audio files
make dist/song.mp3 # when you want a mp3 file
```

### Docker 

Build a docker image.

```
docker build --rm -t taktmake .
```

```
# when you want all audio files
docker run --rm -v `pwd`:/mnt -e LUID=`id -u` -e LGID=`id -g` taktmake

# when you want a mp3 file
docker run --rm -v `pwd`:/mnt -e LUID=`id -u` -e LGID=`id -g` taktmake dist/song.mp3
```

## License

CC-BY-SA-4.0
