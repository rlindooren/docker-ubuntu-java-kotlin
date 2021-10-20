# docker-ubuntu-java-kotlin

## Why

I created this Docker file to have an easy way to build Java/Kotlin projects in a Linux environment on my Macbook.

Please note that it results in quite a big Docker image. It's a quick and ~~dirty~~ worthy approach 😉.

## How to use

Build the image (one time):

```
docker build --build-arg USER="$USER" -t ubuntu-java .
```

Start the image from your Java/Kotlin project source dir:

```
cd ~/code/your-project
docker run --rm -ti -v "$PWD:/home/$USER/project" ubuntu-java
```

Or... 

To use dependencies already available on your host system
and/or to keep downloaded dependencies
as well as using your existing git config:

```
docker run --rm -ti \
  -v "$HOME/.gradle/:/home/$USER/.gradle/" \
  -v "$HOME/.m2/:/home/$USER/.m2/" \
  -v "$HOME/.konan/:/home/$USER/.konan/" \
  -v "$HOME/.gitconfig:/home/$USER/.gitconfig" \
  -v "$PWD:/home/$USER/project" \
  ubuntu-java
```
