USER := mtscout6
images = jenkins-master

all: data

data:
	@cd jenkins-data && docker build -t $(USER)/jenkins-data .

slave:
	@cd jenkins-slave && docker build -t $(USER)/jenkins-slave .

server:
	@cd jenkins-server && docker build -t $(USER)/jenkins-server .

startdata:
	docker run -d --name jenkins-data $(USER)/jenkins-data echo Data-only container for Jenkins

startserver:
	docker run -d -p 50000:50000 -p 3010:8080 --name jenkins-server --volumes-from jenkins-data $(USER)/jenkins-server

.PHONY: all data startdata statserver
