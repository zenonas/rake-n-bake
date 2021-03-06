Rake-n-Bake
===========

Commonly used Rake tasks
------------------------
...collected together and baked to perfection, ready to serve!


[![Build Status](https://travis-ci.org/RichardVickerstaff/rake-n-bake.svg?branch=master)](https://travis-ci.org/RichardVickerstaff/rake-n-bake)
[![Gem Version](https://badge.fury.io/rb/rake-n-bake.svg)](http://badge.fury.io/rb/rake-n-bake)
[![Code Climate](https://codeclimate.com/github/RichardVickerstaff/rake-n-bake/badges/gpa.svg)](https://codeclimate.com/github/RichardVickerstaff/rake-n-bake)

Rake-n-Bake is a collection of widely applicable Rake tasks used on many projects.
They have been extracted into a gem to allow them to easily be reused and maintained.

Rake-n-Bake tasks are used on the project itself, so you can always take a peek at our [Rakefile](https://github.com/RichardVickerstaff/rake-n-bake/blob/master/Rakefile) or the [tasks themselves](https://github.com/RichardVickerstaff/rake-n-bake/tree/master/tasks) to work out what is going on

Installation
------------
Either:
  1. Add `gem "rake-n-bake"` to your Gemfile and run bundle install.
or
  2. Run `gem install rake-n-bake`

Usage
-----
  1. Add `require "rake_n_bake"` to your Rakefile
  2. Call the tasks that you want, just as with your usual Rake tasks (examples below!).

Tasks
-----
Tasks are namespaced under `:bake` to prevent clashes. For example, the `:ok` task is called by invoking `:bake:ok`

### :bundler_audit
Check the current Gemfile.lock for gem versions with known security issues, courtesy of [Bundler Audit](https://github.com/rubysec/bundler-audit#readme)

### :check_external_dependencies
Check that each command in the `@external_dependencies` array is present on the system path (and fails the task if it isn't)
For example:
  ```ruby
  @external_dependencies = ['ruby', 'postgres', 'foo']
  ```
You can also use the underlying checker object by creating an instance of `RakeNBake::DependencyChecker` with your array of dependencies and calling `#check` or `#missing` on it.

### :code_quality
#### :all
Runs `[:trailing_spaces, :shoulds, :debugger, :pry, :console_log]` tasks. It does not run `:time_check`
##### :trailing_spaces
Check for trailing spaces in `[spec, features, lib, app, factories, db]`.
##### :shoulds
Check for legacy 'it "should blah"' style specs
##### :debugger
Check for debugger statements in `[lib, app, spec, features]`.
##### :pry
Check for binding.pry statements in `[lib, app, spec, features]`.
##### :console_log
Check for console.log statements in `app/assets/javascripys`.
##### :time_check
Check for `Time.now` statements in `[lib, app]` (Time.zone.now is more reliable for servers wanting to use UTC).
This check is NOT part of :all as `Time.zone.now` is an ActiveSupport method.

### :coverage
#### :check_specs
Look at SimpleCov results for spec coverage in `log/coverage/spec` and fail the build if not 100%
#### :check_cucumber
Look at SimpleCov results for Cucumber coverage in `log/coverage/features` and fail the build if not 100%

### :ok
Useful at the end of any Rake tasks which test your application, it prints `***** ALL TESTS PASSED *****`.

### :ok_rainbow
Run this task last to print a more magical version of `:ok`

Handy Tips for new tasks
-----=------------------
- All tasks loaded by `lib/rake_n_bake.rb` will have access to the `RakeNBake::AssistantBaker`. This is intended for truely common things, like logging out when a particular step runs or passes.

Contributing
------------
  1. Make a fork
  2. Make your changes!
    a. Namespace new tasks under `:bake`
    b. Namespace new helpers under `RakeNBake`
  3. Push your changes to your fork
  4. Create a Pull Request
