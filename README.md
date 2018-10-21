
# hledger-docker

This is a Dockerfile for `hledger`. It is using Haskell 8 to build hledger from source.

## Building the image

```
git clone https://github.com/saesh/hledger-docker && cd hledger-docker
docker build -t hledger-docker .
```

## Working with hledger-docker container

The basic container start looks like this:
```
docker run --rm -e LEDGER_FILE=/journals/your.journal -v "/path/to/local/journal/folder:/journals" -p 5000:5000 hledger-docker
```

When starting the Docker container the environment variable `LEDGER_FILE` for the journal file has to be passed into the container. The path to the journal file is the path within the container volume which has to be setup when starting the container with the `-v` option.

By default the container starts `hledger-web` to serve the hledger web interface on port `5000`.

Open http://localhost:5000 to view the web ui of hledger.

### Using hledger tools

The command for the Docker container can be overwritten to use any hledger command by supplying the command as the argument to the container, like `hledger balance`.

```
docker run --rm -e LEDGER_FILE=/journals/your.journal -v "/path/to/local/journal/folder:/journals" -p 5000:5000 hledger-docker hledger balance
```

Outputs the balance of your journal.

To simplify usage an alias can be used:

```
alias hledger='docker run --rm -e LEDGER_FILE=/journals/your.journal -v "/path/to/local/journal/folder:/journals" hledger-docker hledger'
```

Using interactive mode `-it` it is possible to use the interactive entry tool.

```
docker run --rm -e LEDGER_FILE=/journals/your.journal -v "/path/to/local/journal/folder:/journals" -p 5000:5000 hledger-docker hledger add
```

### Using the hledger-docker shell script

The shell script is a wrapper for the `docker run ...` command. Edit it and enter your path to your local folder containing your journals in the `LOCAL_JOURNAL_FOLDER` variable.

The first argument to the script is the journal file to use (from the local journal folder). All other arguments are treated as arguments to the Docker container. If no arguments are provided except the journal file the web ui will be started.

For example to see the balance of your journal:

```
./hledger-docker.sh 2017.journal hledger balance
```
