# lucyfer

Lucyfer is a specialization of the official [Jupyter Datascience Notebook Docker
image](https://hub.docker.com/r/jupyter/datascience-notebook/tags/) that brings
additional tools into the Jupyter environment while maintaining independence
from the local system's development tools.  This empowers the user to use all
Jupyter features without having to install any of the Jupyter packages locally.

**tl;dr:  Lucyfer is a zero-conf, zero-install Python IDE for buiding high
performance computing prototypes.**


## Features

- Git support
- `jq`
- `rclone` for synchronizing data lakes between host and remote systems
- `ssh`
- `tree` (file system visualization)
- Vim with NERDTree and other dev tools
- `pudb`, linters, devpi, `pytest`, `plotly`, and data handling Python tools

Lucyfer also fixes the Conda and `jovyan` (`$NB_USER`) permissions in the 
Jupyter image and enables `pip` package installation.


## Benefits

- Coexists with local file system development tools like IDEs or Python
  virtual environments
- Run experiments against the local code
- Develop production-ready modules and packages from within the Jupyter/Lucyfer
  environment as part of the DevOps process
- Develop and test on macOS and Linux from the same machine without having to
  deploy a full Linux VM (x86, M-processors)


## Quick start guide


### Pre-requisites

- Docker desktop
- `wget` for pulling the files off GitHub


### Workspace

Open a terminal and create a working directory anywhere in your file system, or
pick any existing directory.


### Deployment

Get the starter files from the Lucyfer project at GitHub and execute the runner:

```


```

