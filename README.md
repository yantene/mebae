# Mebae

Social Composing with Takt!

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
docker build --rm -t $USER/taktbuild .
```

```
# when you want all audio files
docker run --rm -v `pwd`:/mnt -e LOCAL_UID=`id -u $USER` -e LOCAL_GID=`id -g $USER` $USER/taktbuild

# when you want a mp3 file
docker run --rm -v `pwd`:/mnt -e LOCAL_UID=`id -u $USER` -e LOCAL_GID=`id -g $USER` $USER/taktbuild dist/song.mp3
```

## License

CC-BY-SA-4.0
