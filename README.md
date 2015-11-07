# Java back-end + JavaScript front-end #

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

* install latests java and npm
* clone repo

        $ git clone ... && cd blog/
* only one command (all in one)

        $ ./gradlew build run # or gradlew.bat build run
* or without gradle wrapper (make jar not war:))
        
        $ java -jar build/libs/blog-1.0.jar # after successful build
*I'm pretty sure, that it should works :) it worked on my home mac os x and company's pc*

* anyway, i've added .travis.yml for build: [![build](https://api.travis-ci.org/daggerok/blog.svg?branch=master)](https://api.travis-ci.org/daggerok/blog.svg?branch=master)

### What is back-end? ###
1. pure java/spring-boot application on gradle
2. hateoas data-rest
3. default db request caching with guava
4. flexible, maintainable and pretty server-side on steroids :) 

* How to test
    - what do we have? index works, okay...
        
        $ curl -XGET http://localhost:8080
    - what's api?
        
        $ curl -XGET http://localhost:8080/api/alps -H "Accept: application/x-spring-data-compact+json"
    - I see.. let's try:
    
        $ curl -XGET http://localhost:8080/api/post -H "Accept: application/x-spring-data-compact+json" 
    - I see... can I save something?
     
        $ curl -XPOST http://localhost:8080/api/posts -H "Content-Type: application/json" \ 
            -d '{"author":"some name","subject":"some topic","body":"trololo..."}'
    - cool, does it really do one annotation? read more about @RepositoryRestResource and Spring at all
    - easy cache config, easy unit and integration testing, easy booting, easy config
    - back-end support and develop very easy :)
    
### What is front-end? ###

* html5/css/js blog skeleton with npm and gulp 
* How to build
    - shell-scripts www/build.{sh,bat} and gradle wrapper
    
        $ ./gradlew www # or gradlew.bat www
    - npm
        
        $ cd www/
        $ npm run gulp
    - gulp
        
        $ gulp
* What gulp does?
    - combine/minify js, css, images
        
        $ gulp min # npm run gulp min
    - replace html parts
        
        $ gulp html # npm run gulp html
    - watching sources and process compile errors with plumber
        
        $ gulp watch # npm run watch

### Who do I talk to? ###

daggerok@gmail.com :)
