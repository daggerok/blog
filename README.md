# Java back-end + JavaScript front-end  [![build](https://api.travis-ci.org/daggerok/blog.svg?branch=master)](https://travis-ci.org/daggerok/blog) #

### What is this repository for? ###

* Do you wanna be full-stack developer?
* This is an example of Java+JavaScript web project with some common and very useful stuff

### Example of full stack web project written on Java + JavaScript ###

***Build system and dependency managers:***

* Gradle
* Bash/batch scripts
* Gulp
* Node package manager

### How do I get set up? ###

install latests java and npm

clone repo

``` shell
git clone --depth=1 --no-single-branch --single-branch https://github.com/daggerok/blog app && cd $_
```

only one command (all in one)

``` shell
./gradlew build run # or gradlew.bat build run
```

or without gradle wrapper (make jar not war:))

```shell
java -jar build/libs/blog-1.0.jar # after successful build
```

I'm pretty sure, that it should works :) it worked on my home mac os x and company's pc

anyway, [i've added .travis.yml for build:](https://travis-ci.org/daggerok/blog) [![build](https://api.travis-ci.org/daggerok/blog.svg?branch=master)](https://api.travis-ci.org/daggerok/blog.svg?branch=master)

### What is back-end? ###

1. pure java/spring-boot application on gradle, travis-ci
2. spring-data, data-rest repositories and HATEOAS
3. default db request caching with spring caching and guava
4. flexible, configurable, maintainable and supper-pretty server-side on steroids :)

### How to test

what do we have? index works, okay...

```shell
curl -XGET localhost:8080
```

what's api?

```shell
curl -XGET localhost:8080/api/alps -H "Accept: application/x-spring-data-compact+json"
```

I see.. let's try

```shell
curl -XGET localhost:8080/api/post -H "Accept: application/x-spring-data-compact+json"
```

I see... can I save something?

```shell
curl -XPOST localhost:8080/api/posts -H "Content-Type: application/json" \
    -d '{"user":"some name","subject":"some topic","body":"trololo..."}'
```

cool, does it really do one annotation? read more about @RepositoryRestResource and Spring at all
- easy cache config, easy unit and integration testing, easy booting, easy config
- back-end support and develop very easy :)

### What is front-end?

1. node package namager
2. gulp developemnt: watching sources with livereloading in the browser
3. html5/css/js blog skeleton (angular/bootstrap app)
4. and karma-jasmine unit tests, travis-ci

### How to build

gradle

```shell
gradle www
```

shell / batch scripts

```shell
cd www/ && ./build.sh # nix systems
cd www && build.bat @rem windows systems
```

npm

```shell
npm run deploy
```

### How to test? Test will handle during the gradle build, build.sh, build.bat or

```shell
npm test
```

### What gulp does?

combine, minify scripts, ctyles, images and html files

```shell
npm run gulp js
npm run gulp css
npm run gulp img
npm run gulp fonts
npm run gulp html
# + dev mode (see gulpfile.coffee)
```

watching sources and process compile errors with plumber, doing it in developer mode with livereload feature (without any browsers plugins or other middleware): http://localhost:8080

```shell
npm start
```
 
running build on http-serve

```shell
npm serve
```

### Heroku

install heroku cli

deploy heroku app

```shell
heroku create
heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git
# wait for message: https://some-words-numbers.herokuapp.com/ deployed to Heroku
git push heroku master
```

open deployed app

```shell
heroku open
```

list heroku apps

```shell
heroku apps
== MyApps
some-words-numbers
```

undeply and remove app:

```shell
heroku apps:destroy --app some-words-numbers
```
