# thermite-rails

Integrate your Rust+Ruby [thermite](https://github.com/malept/thermite) projects
into Rails. Like [helix-rails](https://github.com/tildeio/helix-rails), but for
thermite.

First things first: much of this project was initially "borrowed" from
[helix](http://usehelix.com/) and `helix-rails`, which are wonderful
projects for getting Rust and Ruby working together--you should check them out.

Specs |
------|
[![Build Status](http://teamcity-build.agrian.com/app/rest/builds/buildType%3Aid%3AGems_ThermiteRails_Specs/statusIcon?guest=1)](http://teamcity-build.agrian.com/viewType.html?buildTypeId=Gems_ThermiteRails_Specs)

## Usage

### Generators

There are two Rails generators that get you doing Rust-y things in your Rails app.

#### `thermite:install`

This does one simple thing: adds a line to `config/environments/development.rb`
that checks to see if your crates have been updated since the last time you
built them; if any of them have been updated, you'll get an exception letting
you know.

```bash
$ rails generate thermite:install
```

...adds the following to `config/environments/development.rb`:

```ruby
config.thermite.outdated_error = :page_load
```

#### `thermite:crate [crate-name]`

This generates a new Rust+Ruby project for you in `[Rails.root]/crates/[crate-name]`.
The Rubygem part of the project is created using `bundle gem [crate-name]`; the
Rust part of the project is created using `crate new [crate-name]`. Most of the
basic stuff that `thermite` has you do for setting up is done for you.

One main difference from `thermite`'s instructions, however, is that it does
not set up the same `test` Rake task that `thermite` says to. This is because
`thermite-rails` defines its own set of tasks for you. You can, of course,
override those if you need to.

Lastly, it also:

* makes the crate `publish = false` so you don't accidentally publish it to
  `crates.io`.
* sets `crate-type = ["cdylib"]`, assuming you'll use something like
  [ruru](https://github.com/d-unseductable/ruru) +
  [fiddle](https://github.com/ruby/fiddle) for initializing your Rust+Ruby.

### Rake Tasks

`thermite-rails` defines a task for building, cleaning, updating, and (cargo)
testing a) all of your projects at once, b) each of your projects separately.

* `thermite:build_all`, `thermite:build:[crate-name]` leverage `thermite`'s
  `thermite:build` task.
* `thermite:clean_all`, `thermite:clean:[crate-name]` leverage `thermite`'s
  `thermite:clean` task.
* `thermite:test_all`, `thermite:test:[crate-name]` leverage `thermite`'s
  `thermite:test` task.
* `thermite:update_all`, `thermite:update:[crate-name]` are only defined in
  `thermite-rails`. This simply runs `cargo update` for each of your crates.

If you have `rspec` in your stack, you'll also get `spec:crates` and
`spec:crates:[crate-name]`, where the latter will ensure
`thermite:build:[crate-name]` is run before (to make sure specs are run against
the latest Rust code). If you want to run all tests (Rust and Ruby ones) when
you run `rake spec`, add this to the `Rakefile` in the root of your Rails
project:

```ruby
Rake::Task['spec'].enhance do
  Rake::Task['spec:crates'].invoke
end
```

Note that Rake tasks will only be available for crates in `crates/` that use
`thermite`. You can add Rust-only crates under `crates/` (perhaps you want to
keep your crates/projects slim and extract out some functionality?) or use
[helix](http://usehelix.com/) along side `thermite`/`thermite-rails`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thermite-rails'
```

And then execute:

```bash
$ bundle
$ rails generate thermite:install
```

...then go add some crates/projects to your app:

```bash
$ rails generate thermite:crate new_fast_thingy
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Code of Conduct

Everyone interacting in the Thermite::Rails project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://bitbucket.com/agrian/thermite-rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
