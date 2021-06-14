FROM datamachines/cudnn_tensorflow_opencv:11.2.2_2.5.0_4.5.2-20210601

RUN apt-get install -y \
    libboost-all-dev \
    libdevil-dev

# https://github.com/uav4geo/pypopsift
# Pull 20200720 code (commit: bfaf7a9913d6588e8794f376be62d30f9d06fcde)
# https://github.com/alicevision/popsift
# Pull 20210515 code (commit: 305078fa9ba5112b3415300422a45ba9800df2a7)
RUN mkdir -p /wrk \
    && cd /wrk \
    && git clone --recurse-submodules https://github.com/uav4geo/pypopsift \
    && cd pypopsift \
    && git checkout bfaf7a9913d6588e8794f376be62d30f9d06fcde \
    && perl -pi.bak -e 's%b584a125be8154c81a2b6cd46cc73e2b3a014e38%305078fa9ba5112b3415300422a45ba9800df2a7%' CMakeLists.txt \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j `nproc`\
    && cd .. \
    && pip3 install . \ 
    && cp /wrk/pypopsift/build/_deps/popsift-build/Linux-x86_64/libpopsift.so.1.0.0 /usr/local/lib/ \ 
    && ldconfig \
    && rm -rf /wrk/pypopsift

WORKDIR /wrk
CMD /bin/bash
