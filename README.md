# Teaspoon

Teaspoon is a ruby gem. Its purpose is to keep a historic record of Cucumber scenario failures and successes. These executions are stored over time and branches. 

With that information, a developer can identify flaky tests, useless tests, or even functionalities that need testing reinforcements.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'teaspoon'
```

And then execute:

```bash
bundle install
```

Teaspoon uses Cucumber's JSON report. Ensure your Cucumber executions output such report with

```bash
cucumber --format json
```

Also see the `.env.dist` file to add relevant information. Copy to `.env` and fill it with the preferred database system.

At the moment, Teaspoon can store data in a **MySQL** database, **Redis**, or a files and directories system.

## Usage

### Populating the database

Once the installation is complete, add this line to the end of your cucumber execution; for instance, through the use of `Kernel#at_exit`: 
Once installed, you can simply call Teaspoon from within a Ruby application:
 
```ruby
at_exit do
  Teaspoon.measure_and_pour(path_to_cucumber_report, current_branch_name, current_time_in_epoch)
end
```

This method is also separated should you need only one of the two functionalities. This can be useful to `measure` client-side and `pour` server-side, so as to not send the whole report.

```ruby
Teaspoon.measure(path_to_report) #returns data
Teaspoon.pour(data, current_branch_name, current_time_in_epoch) #stores data
```

### Retrieving the data

Finally, to retrieve information from the database of your choice, use

```ruby
Teaspoon.spoonful(constraints)
```

where `constraints` is a Hash.
* If `constraints` has the key `:key`, it will return the list of existing keys. `:key` can be either `'epoch'`, `'branch'`, or `'scenario'`.
* Otherwise, `constraints` accepts three arrays, defining the key values for which we want data. For instance:
```ruby
Teaspoon.spoonful(epoch:[1495725862], 
                  branch: ['master'], 
                  scenario: ['Login with basic user', 'Create a form', 'Pay with credit card'])
```

Will return the status of these three scenarios when executed against *master* on Thursday, 25 May 2017 15:24:22 GMT

An additional key for constraint is `feature`. As with cucumber, it will return all scenarios inside that feature.

The format of the data is:
```ruby
[
    {
        epoch: Fixnum,
        branch: String,
        scenario: String,
        success: TrueClass || FalseClass,
        feature: String
    },
    #...
]
```

### Retrieval example

Imagine you need to know the test health of scenarios related with credit cards; but you don't know which scenarios there are. You can do
```ruby
scenarios = Teaspoon.spoonful(key:'scenario') 
#scenarios will be ['Login with basic user', 'Create a form', 'Pay with credit card']
```

From there, you may pick the *Pay with credit card* scenario as a constraint, and get the success story across al branches at all times:

```ruby
credit_card_test_results = Teaspoon.spoonful(scenario: ['Pay with credit card'])
```

Additionally, if you just want to check the results on the *master* branch (a name well known), you can just add it.


```ruby
credit_master_test_results = Teaspoon.spoonful(branch: ['master'], scenario: ['Pay with credit card'])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. 

Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Teaspoon has (rather recursively) its own functional Cucumber tests, under the `tests/` folder. One must `bundle install` the tests' gems to run it. `bundle exec cucumber` will run them.

## Contributing

Please see this repo's project to see proposed upgrades to this Gem. The most expandable feature is database type connections.

