# Practical Docker

This is sample project to accommodate my "Practical Docker" presentation.
Clone this repository and then follow all the instructions listed in this README.

## Installation

You will need **2** things installed

- Docker
- [Git](https://git-scm.com/downloads)

Optionally, a good text editor.
I highly recommend [VS Code](https://code.visualstudio.com/) with the [Docker Extension](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker).

If you wish to go all the way you can (optionally) install the following:

- [jq](https://github.com/stedolan/jq/wiki/Installation)

### Docker installation

- For modern OS'es you can find download instructions [here](https://store.docker.com/search?offering=community&type=edition)
- If your OS version is **not** supported by the native clients then you will need to install `docker toolbox` - https://docs.docker.com/toolbox/overview/

There are two items of note

- Docker requires a slew of permissions to run. So please make sure you grant Docker **all** the permissions it needs

- Please treat this installation like any other. Different operating systems and different set ups (especially in company-issued laptops) can make this installation tricky. Google, and perhaps your desktop support team (if using a company-issued laptop) are your friends. Debugging this can be tricky.

### Testing your installation
```bash
docker version;
Client: Docker Engine - Community
 Version:           19.03.5
 API version:       1.40
 Go version:        go1.12.12
 Git commit:        633a0ea
 Built:             Wed Nov 13 07:22:34 2019
 OS/Arch:           darwin/amd64
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          19.03.5
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.12
  Git commit:       633a0ea
  Built:            Wed Nov 13 07:29:19 2019
  OS/Arch:          linux/amd64
  Experimental:     true
 containerd:
  Version:          v1.2.10
  GitCommit:        b34a5c8af56e510852c35414db4c1f4fa6172339
 runc:
  Version:          1.0.0-rc8+dev
  GitCommit:        3e425f80a8c931f88e6d94a8c831b9d5aa481657
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

## Warm up your engines!

**You want to do this BEFORE you show up for the workshop!!**
Running this over a hotel wifi connection might not go well.
Using the command (bash) prompt:

```bash
docker pull alpine:3.12;
docker pull jenkins/jenkins:2.225;
docker pull mongo:3.6.17;
docker pull nginx:1.17.9-alpine;
docker pull openjdk:8u131-jdk;
docker pull openjdk:8u131-jre;
docker pull portainer/portainer:latest;
docker pull tomcat:9;
docker pull ubuntu:20.10;
docker pull fedora:33;
```

## The final test

Once again, at the command prompt:

```bash
> docker run -d --name myjenkins -p 8080:8080 jenkins/jenkins:2.225;
> docker logs -f myjenkins;
```

You should see the Jenkins logs flowing by eventually settling with the following:

```
Sep 18, 2018 11:38:19 PM hudson.model.UpdateSite updateData
INFO: Obtained the latest update center data file for UpdateSource default
Sep 18, 2018 11:38:19 PM hudson.WebAppMain$3 run
INFO: Jenkins is fully up and running
Sep 18, 2018 11:38:19 PM hudson.model.UpdateSite updateData
INFO: Obtained the latest update center data file for UpdateSource default
Sep 18, 2018 11:38:20 PM hudson.model.DownloadService$Downloadable load
INFO: Obtained the updated data file for hudson.tasks.Maven.MavenInstaller
Sep 18, 2018 11:38:20 PM hudson.model.DownloadService$Downloadable load
INFO: Obtained the updated data file for hudson.tools.JDKInstaller
Sep 18, 2018 11:38:20 PM hudson.model.AsyncPeriodicWork$1 run
INFO: Finished Download metadata. 7,798 ms
--> setting agent port for jnlp
--> setting agent port for jnlp... done
```

Visit http://localhost:8080 and see if you see the Jenkins login page.
If you do, you are all set to go!!

```bash
# ctrl-c to break out of the logs
docker container stop myjenkins;
docker container rm myjenkins;
```

Woot!!!
See you soon!!!

## Notes

- This project consists of a slew of Dockerfiles that demonstrate how to (and **not** to) use a few select Dockerfile instructions
- This project also packages the artifact that this project produces so you do **not** need Java installed
