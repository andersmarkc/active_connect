# ActiveConnect
Short description and motivation.

## Usage
How to use my plugin.


# Guide ME
RAILS_ENV=test rails db:create
RAILS_ENV=test rails generate active_connect:install
RAILS_ENV=test rails test

# Create Migration in dummy app
cd test/dummy/
RAILS_ENV=test rails generate migration CreateProducts name:string --app=dummy
RAILS_ENV=test rails db:migrate

# Drop
RAILS_ENV=test rails db:drop


# RAILS_ENV=test rails db:drop

## Installation
Add this line to your application's Gemfile:

```ruby
gem "active_connect"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install active_connect
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
