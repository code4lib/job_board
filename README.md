# Job Board

A Ruby on Rails job post aggregator for the code4lib community.

[![Build Status](https://travis-ci.org/cbeer/job_board.svg?branch=master)](http://travis-ci.org/cbeer/job_board)
[![Code Climate](https://codeclimate.com/github/cbeer/job_board/badges/gpa.svg)](https://codeclimate.com/github/cbeer/job_board)
[![Coverage Status](https://coveralls.io/repos/cbeer/job_board/badge.svg)](https://coveralls.io/r/cbeer/job_board)
## Installing

To install the Job Board, you need the following:

- Ruby 2.3 or greater
- A database engine, e.g. MySQL, Postgresql, or SQLite3 
- A compatible JavaScript installation for asset compilation (see https://github.com/sstephenson/execjs#readme)

```console
$ bin/setup
$ rake db:migrate
$ rails server
```

The application should be available at http://127.0.0.1:3000.

### Loading seeds

Fetch the `dump.tar.gz` file from https://archive.org/details/jobs.code4lib.org and extract it into `./tmp/dump`.

```
$ rake db:seed
```

## Tests

To run the tests:

```console
$ rake
# or
$ rspec
```
