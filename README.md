# Rottendesk

Ruby client for [Freshdesk](https://freshdesk.com) that uses the [JSON API](http://freshdesk.com/api) of Freshdesk.

[![Code Climate](https://codeclimate.com/github/abdulsattar/rottendesk/badges/gpa.svg)](https://codeclimate.com/github/abdulsattar/rottendesk)

## Installation

Add this line to your application's Gemfile:

    gem 'rottendesk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rottendesk

## Usage

``` ruby
rottendesk = Rottendesk::App.new('domain.freshdesk.com', 'username/key', 'password')

rottendesk.User.find(<user_id>)
=> #<Rottendesk::User:0x007f1d9935d438
  @active=true,
  @name = "Eddard Stark"
  @address="1 Winterfell"
  ...

rottendesk.User.where(options)
=> [#<Rottendesk::User:0x007f1d9935d438
  @active=true,
  @name = "Eddard Stark"
  @address="1 Winterfell"
  ...,
  #<Rottendesk::User:0x007f1d9935d438
  @active=true,
  @name = "Bran Stark"
  @address="2 Tree"]
```

## Contributing

1. Fork it ( https://github.com/abdulsattar/rottendesk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
