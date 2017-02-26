# Job Board

A Ruby on Rails job post aggregator for the code4lib community.

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

## Tests

To run the tests:

```console
$ rake
# or
$ rspec
```
