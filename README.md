# Freshdesk

Ruby client for [Freshdesk](https://freshdesk.com) that uses the [JSON API](http://freshdesk.com/api) of Freshdesk.

## Installation

Add this line to your application's Gemfile:

    gem 'freshdesk-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install freshdesk-api

## Usage

``` ruby
freshdesk = Freshdesk::App.new('domain.freshdesk.com', 'username/key', 'password')

freskdesk.User.find(<user_id>)
=> #<Freshdesk::User:0x007f1d9935d438
  @active=true,
  @name = "Eddard Stark"
  @address="1 Winterfell"
  ...

freshdesk.User.search(options)
=> [#<Freshdesk::User:0x007f1d9935d438
  @active=true,
  @name = "Eddard Stark"
  @address="1 Winterfell"
  ...,
  #<Freshdesk::User:0x007f1d9935d438
  @active=true,
  @name = "Bran Stark"
  @address="2 Tree"]
```

## Contributing

1. Fork it ( https://github.com/abdulsattar/freshdesk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
