# Dockerfile for PyPopSIFT

Build [pypopsift](https://github.com/uav4geo/pypopsift) with a more recent version of [popsift](https://github.com/alicevision/popsift) within a Docker container.

Base container is from https://github.com/datamachines/cuda_tensorflow_opencv so it provides OpenCV and the `pypopsift` python example works (our version just adapted the test image location to be in the directory of this `README.md` and name `test.jpeg`).

Build: ```docker build --tag cto_pypopsift:local .```

Start (with GPUs and mounting `pwd` within the container as `/dmc`): ```docker run --rm -it -v `pwd`:/dmc --gpus all cto_pypopsift:local```

Test (within previously run container, requires you to place `test.jpeg`image file in the same directory as this `README.me`): ```python3 /dmc/pypopsift_test.py```
