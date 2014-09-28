source 'https://rubygems.org'
ruby '2.1.2'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

gem 'puma'

gem 'bugsnag'
# Component requirements
gem 'bcrypt'
gem 'sass'
gem 'slim'
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '>= 3.1', :require => 'active_record'

group :development, :test do
  gem 'sqlite3'
  gem 'dotenv'
end

group :production do
  gem 'pg'
end

# Test requirements
gem 'rspec', :group => 'test'
gem 'rack-test', :require => 'rack/test', :group => 'test'

# Padrino Stable Gem
gem 'padrino', '0.12.3'

gem 'twilio-ruby'

gem 'awesome_print'
gem 'pry'
gem 'ruby_spark'

gem 'sucker_punch'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.3'
# end
