source 'https://rubygems.org'


# CORE --------------------------------------------------

gem 'rails', '~> 4.1.1'                         # ...
gem 'puma'

# SECURITY & MIDDLEWARE ---------------------------------

gem 'devise'                                    # user authentication
  gem 'devise-async'                            # send user auth emails in background
  gem 'devise-encryptable'                      # allows us to plug pbkdf2 into devise
  gem 'pbkdf2-ruby'                             # our key derivation function for storing passwords

gem 'cancancan'                                 # user authorization & permissions


# BACKENDS ----------------------------------------------

gem 'pg'                                        # postgres is rather nice
  gem 'activerecord-postgres-hstore'            # but this adds native serialized hashes

gem 'redis-rails'                               # plug redis in as our cache provider
gem 'dalli'                                     # memcached also available

gem 'sidekiq'                                   # kickass background processing
  gem 'sidekiq-status'                          # lets us communicate with running background processes
  gem 'sidekiq_mailer'                          # send all email in the background


# MODELS ------------------------------------------------

gem 'default_value_for'                         # shiny attribute defaulting
gem 'attribute_normalizer'                      # shiny attribute normalizing

gem 'geocoder'                                  # any model can be geolocated
gem 'state_machine'                             # any model can behave as a state machine (or many)

gem 'paper_trail'                               # model versioning

gem 'kaminari'                                  # dead-simple pagination for activerecord calls


# SERVICES & INTEGRATION --------------------------------

# gem 'fog'


# ASSETS, VIEWS, & RENDERING ----------------------------

gem 'jquery-rails'                              # jquery for the win
gem 'turbolinks'                                # prevents browser needing to reload the js environment on each request -- see https://github.com/rails/turbolinks

gem 'rails-backbone', git: 'git://github.com/codebrew/backbone-rails.git', branch: 'master' # backbone core (includes underscore)
gem 'websocket-rails'                           # persistent client connections in channels

gem 'paloma'                                    # controls javascript loading per controller and action

gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git', branch: 'bootstrap3' # bootstrap is shiny
  gem 'bootstrap_form'                          # formbuilder with native bootstrap support

gem 'haml-rails'                                # haml is better than erb any day
  gem 'haml_coffee_assets'                      # allows use of haml/coffee templates for backbone
gem 'jbuilder', '~> 2.0'                        # simple json api builder -- see: https://github.com/rails/jbuilder
gem 'sass-rails', '~> 4.0.3'                    # use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'                      # js compressor

gem 'coffee-rails', '>= 4.0.0'                  # I dislike coffeescript, but I'm leaving it on for default compatibility



# LIBRARIES ---------------------------------------------

gem 'chronic'                                   # gives us natural-language time parsing

gem 'useragent'                                 # a simple way to get at browser info


# TESTING -----------------------------------------------

group :development, :test do

  gem 'rspec-rails'                             # use rspec for testing
    gem 'shoulda-matchers'                      # nice and simple matcher suite
    gem 'fuubar', '2.0.0.rc1'                   # better progressbar -- once 2.0.0 is released remove the conditional

  gem 'factory_girl_rails'                      # a better approach to test fixtures
  gem 'faker'                                   # a better way to generate fake data

end

# CONSOLE, DOCS, & DEPLOYMENT ---------------------------

gem 'hirb'                                      # gives us much nicer console output
gem 'sdoc', '~> 0.4.0',   group: :doc           # bundle exec rake doc:rails generates the API under doc/api.

group :development do

  gem 'letter_opener'                           # have emails pop up in a browser
  gem 'better_errors'                           # better error page when an exception is raised
    gem 'binding_of_caller'                     # enables immediate stack tracing in the browser

  gem 'foreman',          require: false        # launch control for dev purposes
  gem 'engineyard',       require: false        # deployment capabilities

end



