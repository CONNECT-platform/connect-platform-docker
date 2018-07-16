# connect-platform-docker
docker file (and a testing/quick deploying script) for connect-platform.
for building the image and running it, just do the following:
1. make sure you have [docker engine installed](https://www.docker.com/community-edition).
1. create a folder and `cd` there.
1. `git clone https://github.com/loreanvictor/connect-platform-docker.git`
1. `chmod +x ./just`
1. `./just build`
1. `./just run`


## full list of commands:
### build
```
./just build
```
well, builds an image based on the dockerfile :)


### run
```
./just run
```
runs the image built with `./just build`


### kill
```
./just kill
```
kills any containers that were started by `./just run`

### shell
```
./just shell
```
connects to the container started by `./just run`

### clean
```
./just clean
```
kills everything and cleans built images.

---

## and also:

- checkout [CONNECT platform on git](https://github.com/loreanvictor/connect-platform).
- this is a super early-stage project, but if you want to give feedback, any feedback, be it an idea, improvement, or a super minor issue you've had with the platform, just write to me.
