#!/bin/bash

phonetisaurus predict --model=/model/g2p.fst --nbest=3 < /sources/hsb.vocab > /output/hsb_g2p.lex
