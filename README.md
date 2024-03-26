# dotnet-todo

1. Brief instructions how to run docker container with custom image created from the dotnet source code
## Download image:
docker pull stolek/dotnet-todo-main:latest
## Check the image:
docker images 
#Output example:
root@DESKTOP-1NTM4L3:/home/stole/myapp# docker images
REPOSITORY                    TAG       IMAGE ID       CREATED        SIZE
stolek/dotnet-todo-main       latest    e4105741836a   1 day ago     222MB
## Create the docker container with the custom image
docker run -d -p 5001:8080 stolek/dotnet-todo-main:latest
#Output example:
root@DESKTOP-1NTM4L3:/home/stole/myapp# docker ps
CONTAINER ID   IMAGE                            COMMAND                CREATED      STATUS          PORTS                                               NAMES
84fefa118f6d   stolek/dotnet-todo-main:latest   "dotnet TodoApi.dll"   1 day ago   Up 17 minutes   80/tcp, 0.0.0.0:5001->8080/tcp, :::5001->8080
##  Useful commands
docker start <containerid> #start the container 
docker stop <containerid> #stop the container 
docker logs <containerid> #list logs from containerth 

## Note: tested the app with the new container It's working when i curl the localhost:5001/todoitems but because of the memory database the resquest output is with no data.
Curl put command
curl -X POST -H "Content-Type: application/json" -d '{"name":"Dog","description":"dog is walking"}' http:
//localhost:5001/todoitems
#Output
root@DESKTOP-1NTM4L3:/home/stole/myapp# curl localhost:5001/todoitems
[{"id":1,"name":"Dog","isComplete":false}]

## Test the GET endpoints

Test the app by calling the endpoints from a browser or Postman. The following steps are for Postman.

  Create a new HTTP request.
  Set the HTTP method to GET.
  Set the request URI to https://localhost:<port>/todoitems. For example, https://localhost:5001/todoitems.
  Select Send.

The call to GET /todoitems produces a response similar to the following:

```json
[
  {
    "id": 1,
    "name": "walk dog",
    "isComplete": false
  }
]
```

  Set the request URI to https://localhost:<port>/todoitems/1. For example, https://localhost:5001/todoitems/1.

  Select Send.

  The response is similar to the following:

```json
  {
    "id": 1,
    "name": "walk dog",
    "isComplete": false
  }
```

This app uses an in-memory database. If the app is restarted, the GET request doesn't return any data. If no data is returned, POST data to the app and try the GET request again.
#c
