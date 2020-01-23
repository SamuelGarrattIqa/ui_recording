## Recording UI Tests in gitlab pipeline

---

## Introduction

This presentation will demonstrate using Zalenium to provide a
scalable Selenium Grid with video recording, running this in Gitlab
and Jenkins for a single test execution, and how a test manual can
be created from tests run. 

---

## What is Zalenium

Zalenium provides a dockerised Selenium Grid that creates Chrome and Firefox nodes on demand.
It also provides video recording which is the focus of this presentation.

Let's start up our docker-compose configuration with following command:

`
docker-compose -f docker-compose-demo.yml up --abort-on-container-exit --exit-code-from test
`

---

## Observing it run 

At the [console](http://localhost:4444/grid/console) you see a console of nodes, showing
the pending requests for more nodes
You will notice how 4 nodes have been created by running 

`
docker ps
`

Look at the [live preview](http://localhost:4444/grid/admin/live) of the nodes running. 
and a [dashboard of the tests finished](http://localhost:4444/dashboard/). 

---

## Gitlab Components

* Gitlab runner on docker image (runs everything)
* docker:19.03.5-dind service allowing docker from within docker image
* docker-compose (creating network with Zalenium connected to test suite)
* Ruby coded framework (this could be replaced by any language/test tool)
* Zalenium container which creates chrome/firefox containers on demand

---

## How they fit together

![Recording Configuration](assets/img/RecordingConfig.png)

---

## What this recording allows

* One to easier to debug UI failures
* Provide demo of UI tests
* Could be a medium for training documentation
* (Zalenium also removes the need for the test tool to have browsers installed)

---

## Docker compose file defining container network

* Zalenium image to host browser containers behind a Selenium grid and record tests
* Image used to run the test 

---?code=docker-compose.yml&lang=yaml&title=docker-compose.yml

@[5-6](Defining Zalenium open source image)
@[7](Hostname given so that tests using it have easy reference name)
@[9-10](Sharing volume where video is stored to gitlab runner)
@[9,11](Docker socket shared so Zalenium can create its own containers)
@[12,13](Zalenium hosted on port 4444 within docker-compose network)
@[14](Command to start zalenium without sending statistics)
@[15,17](Pulls default Selenium image used to create browser images)
@[18-19](Build test image from source Dockerfile)
@[20](Shell script to run tests when ready)
@[21-22](Uses code in repo within container, sharing logs back)
@[25-26](Setting an environment variable with the location of the Selenium grid)
@[29](Specifying what browser to run)

---

# Shell script to poll until Selenium grid's status is up and running

---?code=run_tests_when_ready.sh

@[2](Wait until zalenium is up. Takes into account downloading Zalenium image)
@[3-4](Commands that runs tests. This can be replaced by any command that runs UI test)

---

# Gitlab CI Config

---?code=.gitlab-ci.yml&lang=yaml&title=Gitlab CI YAML

@[1](Template used so same YAML can be used for multiple browsers)
@[2-3](Uses docker-dind image that allows docker containers to be created within it as a background service for Zalenium)
@[4](Base image itself is docker)
@[6-7](Install docker-compose)
@[6,9](Run docker compose, exiting when tests finish)
@[6,10](Run pandoc to covert markdown into docx)


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
