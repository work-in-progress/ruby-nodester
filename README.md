
WARNING: First version and my first published gem - need to work on docs and specs.

## Nodester

An API wrapper for the nodester API (<http://nodester.com>). The initial version uses a straight approach, an ActiveResource like interface might be added if there is enough interest.

[![Build Status](http://travis-ci.org/scottyapp/nodester.png)](http://travis-ci.org/scottyapp/nodester)

## Install

Include this in your gemfile

gem 'nodester'

## Use
A more detailed description can be found at <http://rubydoc.info/gems/nodester>.

###Some Sample Code

    client = Nodester::Client.new("username","password")

    client.create_app 'myappname','server.js'

    ...

### Note
There are a couple of methods, notably the platform_create_request and platform_status methods that
operate against <http://nodester.com> and not <http://api.nodester.com>, those do not require a userid/password. Just choose dummy/dummy or something similar.

All results are hashes, with strings (not symbols) as keys. 

In case of an error either a ResponseError or a StandardError is raised.

## Dependencies

* Httparty 

## Acknowledgments

Thanks to 

* Aaron Russel (<https://github.com/aaronrussell>) whose cloudapp api helped a lot (some spec code is taken verbatim) 
* John Nunemaker (<https://github.com/jnunemaker>) for httparty and all his other contributions.

## Trivia

This gem was created to the tunes of Natalia Kills and Nicki Minaj.

## Release Notes

### 0.0.5
* Bug Fixing: start stop app, error handling

### 0.0.3
* Updated docs

### 0.0.2
* Bug fix for NPM

### 0.0.1
* First version

## Contributing to Nodester
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Martin Wawrusch. See LICENSE for
further details.

