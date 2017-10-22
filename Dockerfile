FROM haskell:8

# download and build hledger
RUN git clone http://github.com/simonmichael/hledger hledger && cd hledger && stack install

# compile add on commands
RUN /hledger/bin/compile.sh

# create target folder for journal volume
RUN mkdir /journals

VOLUME [ "/journals" ]

EXPOSE 5000

# run hledger web by default
CMD [ "hledger-web", "--serve", "--host", "0.0.0.0" ]