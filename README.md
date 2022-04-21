# Lucyfer

Lucyfer is a specialization of the official [Jupyter Datascience Notebook Docker
image](https://hub.docker.com/r/jupyter/datascience-notebook/tags/) that brings
additional tools into the Jupyter environment while maintaining independence
from the local system's development tools.  This empowers the user to use all
Jupyter features without having to install any of the Jupyter packages locally.

**tl;dr:  Lucyfer is a zero-conf, zero-install Python IDE for buiding high
performance computing prototypes.  It enables data scientists and software
engineers to work off the same code base and use the same tools.**


---
## Features

- Git support
- SPARQL kernel for interactive dataset exploration
- Kotlin kernel for state-of-the-art interactive JVM REPL and exploration
- `jq`
- `pudb`, linters, devpi, `pytest`, `plotly`, and data handling Python tools
- `rclone` for synchronizing data lakes between host and remote systems
- `ssh`
- `tree` (file system visualization)
- Vim with NERDTree and other dev tools

Lucyfer also fixes the Conda and `jovyan` (`$NB_USER`) permissions in the 
Jupyter image and enables `pip` package installation.


### Important

The `lucyfer` image is a specialization of `jupyter/datascience-notebook` and
runs on x86 processors.  It supports Python, Julia, R, and SPARQL kernels.

The `lucyfer-m` image is a specialization of `jupyter/scipy-notebook` and runs
on ARM64 processors.  It only supports Python and SPARQL kernels.


---
## Benefits

- Coexists with local file system development tools like IDEs or Python
  virtual environments
- Run experiments using local code against remote data
- Develop production-ready modules and packages from within the Jupyter/Lucyfer
  environment as part of the DevOps process
- Develop and test on macOS and Linux from the same machine without having to
  deploy a full Linux VM (x86, M-processors)
- Access AWS data lakes without making local copies of remote data


---
## Quick start guide


### Pre-requisites

- Docker desktop
- `wget` for pulling the files off GitHub


### Workspace

Open a terminal and create a working directory anywhere in your file system, or
pick any existing directory.

```zsh
mkdir -p ~/development/mywork && 
cd ~/development/mywork
```


### Deployment

Get the starter files from the Lucyfer project at GitHub and execute the runner:

```zsh
wget https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/lucyfer-compose.yaml && \
wget https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/README-1ST.ipynb && \
wget https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/README-SPARQL.ipynb && \
wget https://raw.githubusercontent.com/pr3d4t0r/lucyfer/master/lucy && \
chmod +x ./lucy && \
./lucy start

```

Docker displays Lucyfer and Kallisto among all the running containers:

```
CONTAINER ID   IMAGE                      COMMAND                  CREATED         STATUS         PORTS                    NAMES
0aad00c6ecdc   pr3d4t0r/lucyfer:latest    "tini -g -- start-no…"   2 seconds ago   Up 2 seconds   0.0.0.0:8805->8888/tcp   lucyfer
5bbec632c314   lyrasis/blazegraph:2.1.5   "/docker-entrypoint.…"   2 seconds ago   Up 2 seconds   0.0.0.0:8889->8080/tcp   kallisto

Lucyfer access token = 1d156b04af64bded5ed6ca274e90a696cfd6f4be06bfbfc7
```


### Open the development lab

Open this URL in your browser:  <a href='http://localhost:8805' target='_blank'>http://localhost:8805</a>

Enter the Lucyfer access token in the field at the bottom of the page, followed
by your password so that you can return the Lucyfer lab any time.


### Next steps... and get to work!

Open the `README-1ST.ipynb` notebook.  It has live instructions on how to check
if the database is running and on how to conclude the Lucyfer setup.


---
## Why Lucyfer?

From _[2010:  Odyssey Two](https://en.wikipedia.org/wiki/2010:_Odyssey_Two)_
by Arthur C. Clarke:

_ALL THESE WORLDS ARE YOURS -- EXCEPT EUROPA.  ATTEMPT NO LANDING THERE._

HAL-9000 transmitted that warning to Earth after fusing with the Monolith and
David Bowman, the Star Child, before Jupiter reached critical mass and
exploded to become a star.

People on Earth named the new star Lucifer, the Morning Star.

Jupiter became a star thanks to the internal transformation that the cosmic 
general purpose tool, the Monolith, enabled.

<img src='./resources/Lucyfer-Discovery.png'>
Linked photo &COPY; 1984 Metro-Goldwyin-Mayer<br><br>


The `Dockerfille` and Compose files associated with this project enabled an 
internal transformation of Jupyter to turn it into an even better tool.


---
## Licensing information

Lucyfer is released under the [BSD-3 license](./LICENSE.txt), and it's based
on the  Jupyter Project, also released under the [BSD-3 license](https://github.com/jupyter/docker-stacks/blob/master/LICENSE.md).
