# README

This is the Event management api.

## Versions

- Ruby version: 2.7.6
- Bundler 2.2.23
- Rails: 7.1.5.1
- PostgreSQL: 12.22
- Redis 6.2 or newer

# Setup

## Prerequisites

### OSX

This assumes you have Homebrew installed.

1. Install postgres `brew install postgresql`

2. Install redis `brew install redis-server`

### WSL2 on Windows

This assumes you are using Ubuntu 20

1. Install postgres `sudo apt install postgresql postgresql-contrib libpq-dev`

2. Start postgres `sudo service postgresql start`

3. Setup postgres user

`sudo -u postgres createuser -s -i -d -r -l -w <<username>>`
`sudo -u postgres psql -c "ALTER ROLE <<username>> WITH PASSWORD '<<password>>';"`

4. Install redis `sudo apt install redis-server`

5. Start redis `sudo service redis-server start`

### Ruby setup

1. Install rvm `\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.7.6`

2. As per rvm instructions on completion to start using RVM you need to run `source $HOME/.rvm/scripts/rvm`

3. Run `gem install bundler:2.3.26`

## Launch the application

1. Clone the repo `git clone git@github.com:nubinary/workersfirst_server.git`

2. `cd workersfirst_server`

3. copy `env.sample` to `.env` and modify env vars. Pay attention to DB_NAME, DB_USERNAME, DB_PASSWORD. They should be good defaults for MacOS with postgres install on OSX with homebrew. On WSL insert the username and password created in the prequisites.

4. Install gem dependencies `bundle install`

5. Create and load the database `rails db:setup`

6. Run the server `rails s`

# Development

## Running the test suite:

`rails t`

## Running the linter

`bundle exec rubocop`

## Debug information

http://localhost:3000/api/info/openapi
http://localhost:3000/api/info/graph

## ERD

`rails diagram:all` and look at doc/\*.svg

## Continuous Integration

Circle CI builds use the configuration in .circleci/config.yml. It will not load env vars from .env file, so any env variable must be defined in the circle CI configuration.

# Updating the production model data

Data model can be exported for loading from boilerplate_client/src/models/static.js, in the client. Export with:

```
rails rhino:open_api_export
```

## External Libraries

`gem 'rack-attack'`
* It was added to avoid brute force attack on the union member validation.

`gem "google-cloud-storage", "~> 1.8", require: false`
* It was added to support uploading static files to the google storage  

`gem 'aws-sdk-sns', '~> 1'`
* It was added to support SMS notifications 

## How to create a Worker account

Your IP must be whitelisted on SEIU server to create a new account as a worker.

Use one of the `member ids` listed bellow:
- 204126656
- 204119892
- 204140686
- 204226398
- 204045232

## How to handle the notification queue

Email and SMS notifications are enqueued in a Redis queue and must be triggered by Sidekiq.
To begin monitoring the queue, use the following command: `bundle exec sidekiq -q activity_notification`
