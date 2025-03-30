# README

This is the Event management api.

## Versions

- Ruby version: 2.7.6
- Bundler 2.2.23
- Rails: 7.1.5.1
- PostgreSQL: 12.22

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

3. Run `gem install bundler:2.2.23`

## Launch the application

1. Clone the repo `git clone https://github.com/Anshumansingho7/event_management_api.git`

2. `cd event_management_api`

3. Install gem dependencies `bundle install`

4. Create and load the database `rails db:setup`

5. Run the server `rails s`
