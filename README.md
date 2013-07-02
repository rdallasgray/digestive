# Digestive

A super-simple microframework to implement Digest Authentication for
Rails apps.

NB USE AT YOUR OWN RISK!

```ruby
include Digestive::Auth
# simple simon
before_filter :authenticate

# authenticate with an authorization strategy
def authenticate_as_admin
  authenticate { |user| user.is_admin? }
end

# get the authenticated user
def set_current_user
  @current_user = authenticate
end
```

## Installation

    $ gem install digestive
