# AppKonfig

Lightweight app configuration for Rails >= 3.0

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
  proxy:
    ip: 127.0.0.1
    port: 8080
  secret_key: DEV_TOKEN

test:
  value: 2
  proxy:
    ip: 127.0.0.1
    port: 8080
  secret_key: TEST_TOKEN

production:
  value: 3
  proxy:
    ip: 10.0.0.10
    port: 8080
```

In `config/secrets.yml`: (optional, not included in version control)
```yaml
production:
  secret_key: PRODUCTION_TOKEN
```

Anywhere in the app:
```ruby
AppConfig.value
AppConfig.proxy.ip
AppConfig.secret_key
```

## Contributing

1. Fork it ( https://github.com/netguru/app_konfig/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
