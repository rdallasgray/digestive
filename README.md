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

# on successful authentication, user stored in instance var
# of including class
@current_user.is_a?(User)
```

## Installation

    $ gem install digestive
