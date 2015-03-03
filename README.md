# AppKonfig

Lightweight app configuration for Rails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'app_konfig'
```

And then execute:

    $ bundle

## Usage

In `config/config.yml`:

```yaml
development:
  value: 1
  secret_key: DEV_TOKEN

test:
  value: 2
  secret_key: TEST_TOKEN

production:
  value: 3
```

In `config/secrets.yml`: (optional, not included in version control)
```yaml
production:
  secret_key: PRODUCTION_TOKEN
```

Anywhere in the app:
```ruby
AppConfig.value
AppConfig.secret_key
```

## Contributing

1. Fork it ( https://github.com/netguru/app_konfig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
