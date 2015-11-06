# Java back-end + JavaScritp front-end #

### What is this repository for? ###

* Do you wanna be full-stack developer?
* This is an example of Java+JavaScript web project with some common and very useful stuff

###Example of full stack web project written on Java + JavaScript ###

***Build system and dependency managers:***

* Gradle
* Bash/batch scripts
* Gulp
* Node package manager

### How do I get set up? ###

* install latests java and npm
* clone repo

        $ git clone ... && cd blog/
* only one command

        $ ./gradlew build run
*I'm pretty sure, that it should works on both - mac and windows*

### What is back-end? ###

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

* How to build
    - gradle + shell-scripts www/build.{sh,bat}
    
        $ ./gradlew www
    - npm
        
        $ cd www/
        $ npm run gulp
    - gulp
        
        $ gulp
    
* What gulp does?
    - combine/minify js
    - combine/minify css
    - minify images
    - replace html parts
    - watching js, css
    - build into server web dir
* Other guidelines

### Who do I talk to? ###

* Repo owner and admin: Maksim Kostromin daggerok@gmail.com 
* Visit my blog http://daggerok.blogspot.com