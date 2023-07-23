# RTTOV Docker image

Builds RTTOV Docker image with python wrapper and hdf5 functionality.

## Instructions

Docker must be installed first.
Once installed, please check the OS-specific instructions for starting Docker.
Clone this repository and enter the directory.

### Installation

The Docker image can be built by simply running:

```
sudo docker build --tag=rttov .
```

The installation directory of RTTOV is, by default, `/usr/local/rttov13`.

### After installation

Once built, the image can be tested with:

```
$ sudo docker run -it rttov
root@<docker-id>: cd /usr/local/rttov13/rttov_test
root@<docker-id>: ./test_rttov13.sh ARCH=gfortran
```
