# Tinkoff

Updated fork of https://github.com/dankimio/tinkoff

What's new: 
1. New REST V2 API endpoint (https://securepay.tinkoff.ru/v2) support
2. Rails 4+ compatibility

Not all operations implemented fully. Please refer to https://oplata.tinkoff.ru/landing/develop/documentation and read the code!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tinkoff2', '~> 0.4.0', require: 'tinkoff', git: 'git@github.com:evgenyantipin/tinkoff2.git'
```


## Usage

Configure the gem with the credentials provided by the bank. If you are using Ruby on Rails, you should do that in an initializer.

```ruby
# config/initializers/tinkoff.rb
Tinkoff.configure do |config|
  config.terminal_key = 'TerminalKey'
  config.password = 'Password'
end
```

Use the client to work with payments.

```ruby
# Parameters: order_id, amount (in kopecks), options (hash, optional)
# DATA — a hash of arbitrary data (up to 20 pairs), "Email" key is recommended
# More info: https://oplata.tinkoff.ru/landing/develop/documentation/Init
response = Tinkoff::Client.init(order.id, 16900, 
                      CustomerKey: user.id,
                      DATA: {Email: 'user@example.com'},
                      Description: description)

# Parameters: payment_id, options (hash, optional)
Tinkoff::Client.confirm(response.payment_id) if response.success?


# Parameters: payment_id, options (hash, optional)
Tinkoff::Client.cancel(response.payment_id)

# Parameters: payment_id, options (hash, optional)
Tinkoff::Client.state(response.payment_id)

# Parameters: payment_id, rebill_id, options (hash, optional)
Tinkoff::Client.charge(1, 2)
```

You can view all available options in the [official documentation](https://oplata.tinkoff.ru/landing/develop/documentation).

About notification callbacks: https://oplata.tinkoff.ru/landing/develop/notifications

```ruby
notification = Tinkoff::Notification.new(params)

if notification.payment_confirmed?
  order = Order.find(notification.get('OrderId')) 
  order.update_attribute(:paid, true)
end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aristofun/tinkoff  
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
