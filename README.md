# Digestive

A super-simple implementation of Digest Authentication for Rails apps.

NB this is WORK IN PROGRESS and NOT FOR USE IN PRODUCTION (or really, anywhere).

```ruby
include Digestive
# authenticate with the default privilege level
before_filter :authenticate

# authenticate with privilege level :staff
# User model must respond to #has_privilege_level?(privilege_level)
before_filter { authenticate_with_privilege_level :staff }

# authenticate with custom privilege check
before_filter { authenticate_user {|user| user.is_in_role?(:admin) }
```

## Installation

    $ gem install digestive
