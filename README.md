# Statistical grapheme to phoneme (G2P) modeling

This is an example project to demonstrate how tooling can be used to generate phonetic
descriptions for words using a statistical approach, assuming that a large enough 
phonetical lexicon exists.

Inputs:
* manually created example lexicon ("lexicon.lex")
* example list of new words ("hsb.vocab") to generate phonemes for
    * see folder "sources/"

Running:

* Build the container using the supplied "Dockerfile"
    * see also inline comments
    
```console
docker build [--build-arg ARCHITECTURE=XXXXX] -t speech_recognition_acoustic_model_training_step1 .
```

* Build argument "ARCHITECTURE":
    * leave out "ARCHITECTURE" to build for x86_64
    * specify the following for different architectures:
        * Raspberry Pi 0/1: ARCHITECTURE=linux_armv6l
        * Raspberry Pi 2/3/4 (32-bit): ARCHITECTURE=linux_armv7l
        * Raspberry Pi 3/4 (64-bit): ARCHITECTURE=linux_aarch64

* Run the example commands to train the lexicon and to predict phonemes for single words or a word list
    * see Dockerfile for details

Outputs:
* model ("g2p.fst") trained from the lexicon
    * see folder "model/"
* generated lexicon ("hsb_g2p.lex") using the model
    * see folder "output/"

## Authors

- Dr. Ivan Kraljevski (Fraunhofer Institute for Ceramic Technologies and Systems IKTS, Dresden, Germany)

- Daniel Sobe (Foundation for the Sorbian people)

## License

See file "LICENSE".
