# UI Test recording in gitlab pipeline

---

## Components

* Gitlab runner on docker image (runs everything)
* docker:19.03.5-dind service allowing docker from within docker image
* docker-compose (creating network with Zalenium connected to test suite)
* Ruby coded framework (this could be replaced by any language/test tool)
* Zalenium container which creates chrome/firefox containers on demand

---

## How they fit together

#![Recording Configuration](assets/img/RecordingConfig.png)

---

## What this allows

* One to easier to debug UI failures
* Provide demo of UI tests
* Could be a medium for training documentation

---

## Docker compose file defining container network

* Zalenium image to host browser containers behind a Selenium grid and record tests
* Image used to run the test 

---?code=docker-compose.yml&lang=yaml&title=docker-compose.yml

@[5-6](Defining Zalenium open source image)
@[7](Hostname given so that tests using it have easy reference name)
@[9-10](Sharing volume where video is stored to gitlab runner)
@[9,11](Docker socket shared so Zalenium can create its own containers)
@[14](Command to start zalenium without sending statistics)
@[15,17](Pulls default Selenium image used to create browser images)
@[18-25](Polls until Selenium grid's status is up and running)
@[26-27](Build test image from source Dockerfile)
@[28](Command to run tests written in cucumber)
@[29-30](Uses code in repo within container, sharing logs back)
@[31-33](This container requires Zalenium to be ready before being run)
@[34-35](Setting an environment variable with the location of the Selenium grid)

---

---?code=.gitlab-ci.yml&lang=yaml&title=Gitlab CI YAML

@[1-3](Uses docker image that allows docker containers to be created within it as a background service for Zalenium)
@[4](Base image itself is docker)

---

## Limitations

* Time it takes to download docker images (compare Jenkins and gitlab times)
(This could be improved through a different runner perhaps)

---

## Things to do

* Could write blog on this. I think it would be beneficial to others
* Show how it could work on other CI systems (e.g. Jenkins)

---

## Questions
