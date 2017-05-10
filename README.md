# Teaspoon

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/teaspoon`. To experiment with that code, run `bin/console` for an interactive prompt.

The purpose of this gem is to save essential data from Cucumber execution reports. At the very least, it saves whether each scenario execution has passed or failed. 

These executions are stored over time and branches. Thus, one can create graphs to see the timed/averaged results of a certain scenario, and draw conclusions from it. Does this one fail too much? Perhaps it is flickering?

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'teaspoon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install teaspoon
    
Observe the `.env.dist` file to add relevant information. Copy to `.env` and fill it.

#### At the moment, Teaspoon can work with MySQL, Redis, or plain files and directories.

## Usage

Once installed, you can simply call it from within a Ruby application:
 
```ruby
Teaspoon.measure(path_to_report, current_branch = 'master')
```

It could also be called after certain cucumber executions via bash, through an intermediate ruby script.

```ruby
#filename "measurer.rb"

require 'teaspoon'
Teaspoon.measure(ARGV[0], ARGV[1])
```
```bash
$ ruby measurer.rb "test_suite/logs/report.json" $CURRENT_BRANCH
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Specifics

This gem can be prone to change, specially on what data to save, and database usage. 

## Contributing

Bug reports and pull requests are welcome on GitHub. Come talk to Daniel Giralt so we can both improve this gem!

