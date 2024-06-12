# fsr

`fsr` listens for file change events and runs RSpecs automatically in rails console. This avoids the rails boot process and provides instant feedback which is crucial for Test Driven Development (TDD).

## Installation

1. Add `fsr` to your app’s `Gemfile` in `test`:

   ```ruby
   group :test do
     gem 'fsr'
   end
   ```

2. Then, in your project directory:

   ```sh
   $ bundle install
   ```

## Usage

Open rails console in test environment.

```rb
 RAILS_ENV=test bundle exec rails c
```

All following examples should be run in this console.

### Run a single spec

```rb
listener = Fsr.listen(['spec/models/user_spec.rb'])
listener.start
```

This will listen to any file change events, automatically load the changed file and run the given spec.

To stop the listener,

```rb
listener.stop
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elamaranae/fsr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/elamaranae/fsr/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fsr project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elamaranae/fsr/blob/master/CODE_OF_CONDUCT.md).
