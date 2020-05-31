# Mebae

Social Composing with Takt!

## How to generate flac

## Docker 

```
docker build --rm -t $USER/takt2flac .
docker run --rm -v `pwd`:/mnt -e LOCAL_UID=`id -u $USER` -e LOCAL_GID=`id -g $USER` $USER/takt2flac
```

## License

CC-BY-SA-4.0
