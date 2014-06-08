source 'https://rubygems.org'


# CORE --------------------------------------------------

gem 'rails', '~> 4.1.1'                         # ...



# BACKENDS ----------------------------------------------

gem 'pg'                                        # postgres is nice,
  gem 'activerecord-postgres-hstore'            # but this adds native serialized hashes



# MODELS ------------------------------------------------

gem 'devise'                                    # user authentication
  gem 'devise-encryptable'                      # allows us to plug pbkdf2 into devise
  gem 'pbkdf2-ruby'                             # our key derivation function for storing passwords

gem 'default_value_for'                         # shiny attribute defaulting
gem 'attribute_normalizer'                      # shiny attribute normalizing
gem 'paper_trail'                               # model versioning

# the state_machine gem is broken in 4.1, unfortunately, but should be brought back when possible
# gem 'state_machine'                           # any model can behave as a state machine (or many)


# ASSETS, VIEWS, & RENDERING ----------------------------

gem 'haml-rails'                                # haml is better than erb any day
gem 'jbuilder', '~> 2.0'                        # simple json api builder -- see: https://github.com/rails/jbuilder
gem 'jquery-rails'                              # jquery for the win
gem 'paloma'                                    # controls on-demand javascript loading
gem 'sass-rails', '~> 4.0.3'                    # use SCSS for stylesheets
gem 'turbolinks'                                # prevents browser needing to reload the js environment on each request -- see https://github.com/rails/turbolinks
gem 'uglifier', '>= 1.3.0'                      # js compressor
gem 'underscore-rails'                          # underscore is awesome

gem 'coffee-rails', '~> 4.0.0'                  # I dislike coffeescript, but I'm leaving it on for default compatibility



# LIBRARIES ---------------------------------------------

gem 'chronic'                                   # gives us natural-language time parsing
gem 'tzinfo'                                    # time zone data library

gem 'useragent'                                 # a simple way to get at browser info



# CONSOLE, DOCS, & DEPLOYMENT ---------------------------

gem 'hirb'                                      # gives us much nicer console output
gem 'sdoc', '~> 0.4.0', group: :doc             # bundle exec rake doc:rails generates the API under doc/api.

gem 'engineyard', group: :development           # deployment capabilities



