# dry-initializer-rails [![Join the chat at https://gitter.im/dry-rb/chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dry-rb/chat)

[![Gem Version](https://badge.fury.io/rb/dry-initializer-rails.svg)][gem]
[![Build Status](https://travis-ci.org/nepalez/dry-initializer-rails.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/nepalez/dry-initializer-rails/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/nepalez/dry-initializer-rails/badges/coverage.svg)][coveralls]
[![Inline docs](http://inch-ci.org/github/nepalez/dry-initializer-rails.svg?branch=master)][inchpages]

[gem]: https://rubygems.org/gems/dry-initializer-rails
[travis]: https://travis-ci.org/nepalez/dry-initializer-rails
[codeclimate]: https://codeclimate.com/github/nepalez/dry-initializer-rails
[coveralls]: https://coveralls.io/r/nepalez/dry-initializer-rails
[inchpages]: http://inch-ci.org/github/nepalez/dry-initializer-rails

Rails plugin to [dry-initializer][dry-initializer]

[dry-initializer]: https://github.com/dry-rb/dry-initializer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-initializer-rails'
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install dry-initializer-rails
```

## Synopsis

The gem provides value coercion to ActiveRecord instances.

Add the `:model` setting to `param` or `option`:

```ruby
require 'dry-initializer'
require 'dry-initializer-rails'

class CreateOrder
  extend Dry::Initializer

  # Params and options
  param  :customer, model: 'Customer'                 # use either a name
  option :product,  model: Product                    # or a class
  option :coupon,   model: Coupon.where(active: true) # or relation

  def call
    Order.create customer: customer, product: product, coupon: coupon
  end
end
```

Now you can assign values as pre-initialized model instances:

```ruby
customer = Customer.create(id: 1)
product  = Product.create(id: 2)
coupon   = Coupon.create(id: 3, active: true)

order = CreateOrder.new(customer, product: product, coupon: coupon).call
order.customer # => #<Customer @id=1 ...>
order.product  # => #<Product @id=2 ...>
order.coupon   # => #<Coupon @id=3 ...>
```

...or their ids:

```ruby
order = CreateOrder.new(1, product: 2, coupon: 3).call
order.customer # => #<Customer @id=1 ...>
order.product  # => #<Product @id=2 ...>
order.coupon   # => #<Coupon @id=3 ...>
```

The instance is envoked using method `find_by!(id: ...)`.

```ruby
order = CreateOrder.new(1, product: 2, coupon: 4).call
# raises #<ActiveRecord::RecordNotFound>
```

You can specify custom `key` for searching model instance:

```ruby
require 'dry-initializer-rails'

class CreateOrder
  extend Dry::Initializer

  param  :customer, model: 'User', find_by: 'name'
  option :product,  model: Item,   find_by: :name
end
```

This time you can pass names (not ids) to the initializer:

```ruby
order = CreateOrder.new('Andrew', product: 'the_thing_no_123').call

order.customer # => <User @name='Andrew' ...>
order.product  # => <Item @name='the_thing_no_123' ...>
```

## Compatibility

Tested under [MRI 2.2+](.travis.yml).

## Contributing

* [Fork the project](https://github.com/nepalez/dry-initializer-rails)
* Create your feature branch (`git checkout -b my-new-feature`)
* Add tests for it
* Commit your changes (`git commit -am '[UPDATE] Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

