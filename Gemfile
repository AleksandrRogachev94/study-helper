source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.20.0'
gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'
gem 'devise', '~> 4.2'
gem 'pundit', '~> 1.1'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth', '~> 1.6'
gem 'active_model_serializers'
gem 'sidekiq', '~> 4.1', '>= 4.1.2'
gem 'figaro'

gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'delayed_paperclip', '~> 3.0', '>= 3.0.1'
gem 'paperclip'
gem 'aws-sdk', '~> 2.9', '>= 2.9.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
