FROM debian:bullseye-slim
MAINTAINER Daniel Sobe <daniel.sobe@sorben.com>

# normal call
# docker build -t speech_recognition_statistical_g2p_modeling .

# normal call for Raspberry Pi 32 bit
# docker build --build-arg ARCHITECTURE=linux_armv7l -t speech_recognition_statistical_g2p_modeling .

# rebuild from scratch
# docker build -t speech_recognition_statistical_g2p_modeling . --no-cache

# enable in case you want to install tools from contrib or non-free
# RUN sed -i 's/ main/ main contrib non-free/' /etc/apt/sources.list

ARG ARCHITECTURE=manylinux1_x86_64

RUN apt update

############################################
# Install the "phonetisaurus-pypi" tooling
############################################

# get development environment
RUN apt install -y python3 python3-dev python3-wheel python3-setuptools python3-pip

# fetch the tool
RUN apt install -y git make
RUN git clone https://github.com/rhasspy/phonetisaurus-pypi.git phonetisaurus-pypi
RUN cd phonetisaurus-pypi && git checkout v0.3.0

# create all installation packages
RUN cd phonetisaurus-pypi && make dist

# install for the architecture of choice
RUN pip3 install /phonetisaurus-pypi/dist/phonetisaurus-0.3.0-py3-none-${ARCHITECTURE}.whl

# create folders for exchanging data with the container
RUN mkdir -p sources && mkdir -p model &&  mkdir -p output 

# add the helper script for predicting from a list
ADD predict_list.sh /

# just a default instruction, might be handy
CMD ["/bin/bash"]

#########################################################
# how to run the example commands
#########################################################

## mkdir -p model && mkdir -p output 

# create a new model from the provided lexicon
## docker run --mount type=bind,source="$(pwd)"/output,target=/output/ --mount type=bind,source="$(pwd)"/sources,target=/sources/ --mount type=bind,source="$(pwd)"/model,target=/model/ -it speech_recognition_statistical_g2p_modeling phonetisaurus train --model /model/g2p.fst /sources/lexicon.lex

# get predictions from the model for a new word
## docker run --mount type=bind,source="$(pwd)"/output,target=/output/ --mount type=bind,source="$(pwd)"/sources,target=/sources/ --mount type=bind,source="$(pwd)"/model,target=/model/ -it speech_recognition_statistical_g2p_modeling phonetisaurus predict --model=/model/g2p.fst --nbest=5 ĆOPŁOBĚŁU

# get predictions from the model for a list of words
## docker run --mount type=bind,source="$(pwd)"/output,target=/output/ --mount type=bind,source="$(pwd)"/sources,target=/sources/ --mount type=bind,source="$(pwd)"/model,target=/model/ -it speech_recognition_statistical_g2p_modeling /predict_list.sh
