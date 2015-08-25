# store_method

This gem offers very simple approach to cache heavy ActiveRecord instance methods in the database. You just add corresponding field to the database, add store_method line and then just drink your coffee, no other changes needed!

Heavy methods are methods which consume some time and resources to compute their returned value. If that value does not change over time, storing it to the database is a good idea. Actually this functionality is very similar to existing cachethod, cache_method and method_cacheable gems, but all those gems are using Rails.cache to store computed values. In case if you don't want to bother with Rails.cache, use store_method to store computed values right in the database, it's clean and simple!

## Install

In Gemfile

```ruby
gem 'store_method', github: 'fomichov/store_method'
```

Then run

```
bundle install
```

## Basic Usage

Consider gravatar_url instance method which fetches corresponding Gravatar URL for User. This method always takes some time to request www.gravatar.com API so let's store its returned value in the corresponding database field.

```ruby
class User < ActiveRecord::Base
  def gravatar_url
    ...
  end
end
```

First create corresponding database field
```
rails g migration AddGravatarURLToUsers gravatar_url:string
```

(Notice that database column type should match the type that our method returns, any valid column type is supported)

Then include **StoreMethod** module to our model class, and add store_method call with a method name

```ruby
class User < ActiveRecord::Base
  include StoreMethod
  store_method :gravatar_url

  def gravatar_url
    ...
  end
end
```

Passing multiple method names is also supported:
```ruby
store_methods :gravatar_url, :friends_count
```

## Refreshing value
In case if you need to refresh stored value, call stored method with "refresh_" prefix like this:

```ruby
user = User.first
user.refresh_gravatar_url
SQL (5.7ms)  UPDATE `users` SET `users`.`avatar_url` = 'http://www.gravatar.com/avatar/fc383b8294226d72f3a7828eeef86987?d=https%3A%2F%2Fidenticons.github.com%2Ffc383b8294226d72f3a7828eeef86987.png&s=42' WHERE `users`.`id` = 1
 => "http://www.gravatar.com/avatar/fc383b8294226d72f3a7828eeef86987?d=https%3A%2F%2Fidenticons.github.com%2Ffc383b8294226d72f3a7828eeef86987.png&s=42" 
```


## Caveats

Calling stored method with arguments passes these arguments to original method:

```ruby
class Item < ActiveRecord::Base
  include StoreMethod
  store_method :friends_count

  def friends_count(degree = 1)
    ...
  end
end
```

This call returns default (stored) value:
```ruby
user.friends_count
 => 
 100
 ```

This call returns new value calculated using degree argument:
```ruby
user.friends_count(5)
 => 
 100500
 ```

Notice that passing argument won't update stored value.


## Contributing to store_method

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project
* Implement your fix or feature
* Add tests for your changes and make sure that all tests are passing
* Post a pull request

## License

This library is distributed under the Beerware license.
