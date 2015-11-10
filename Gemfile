source 'https://rubygems.org'
#ruby '1.9.3'
ruby '2.0.0'

gem 'rails', '3.2.11' #the foundation
gem 'jquery-rails', '2.1.2' #adds jquery language
gem 'bootstrap-sass', '3.1.0' #twitter's incredible cross-browser formatting tool #i want to delete this, but it actually helps my header and footer work
gem 'bcrypt-ruby', '3.0.1' #this is to hash passwords, for security purposes in case someone hacks into database
gem 'faker', '1.0.1' #this is for testing, to generate fake data; not interested #nominated for deletion
gem 'will_paginate', '3.0.3' #pagination #not paginating anything #nominated for deletion
gem 'bootstrap-will_paginate', '0.0.5' #pagination #not paginating anything these days #nominated for deletion
gem 'carrierwave' #uploads images
gem 'delayed_job_active_record' #delayed jobs/workers
gem "sidekiq" #adds multitasking ability to app
gem 'carrierwave_backgrounder', '0.1.3' #this is to make image uploading in background
gem 'fog', '~> 1.3.1' #adds amazon uploading feature
#gem 'aws-s3', :require => 'aws/s3' #stores image data on amazon for quick dl
#gem 'carrierwave_direct' #uploads directly to S3 in the background (joint with sidekiq)
gem "rmagick" #modifies image uploads
gem "omniauth-google-oauth2" #this allows you to sign in to the app through google id; not implemented yet #nominated for deletion

gem 'pg', "~> 0.14.1.pre" #adds postgres databasing feature
gem 'newrelic_rpm' #3rd party plug-in that evaluates speed of website
gem 'amistad' #adds friend-type relationships #not doing friend-type relationships. #nominated for deletion #make sure to check site
gem 'redis' #this is for sidekiq and search autocomplete
gem 'sinatra', require: false #this is to see sidekiq processes through GUI
gem 'slim' #this is to see sidekiq processes through GUI
gem 'capistrano' #this deploys sidekiq
gem 'rack-timeout' #this helps with timeout issues
gem 'rack-mini-profiler' #this is for testing how much time it takes for a search #nominated for deletion
gem 'intercom-rails', '~> 0.2.14' #this is to see who is using my app at the moment when i sign into intercom
gem 'chardinjs-rails' #this is simple overlay instructions (which we don't use yet) for onboarding #nominate for deletion
gem 'garlicjs-rails' #this is automatically persist forms' text field values locally until form is submitted, this works even if they accidentally close tab or browser! awesome! but I don't have it installed yet #nominated to get this to work!
#also check out parsleyjs to validate front end on forms
gem "fitvids-rails", "~> 1.1.0" #, "~> 1.0.3" #makes videos responsive to screen size
gem 'mini_magick' #app crashes without this; error is likely from ckeditor installation
gem 'ckeditor' #this gives the post forms extra options like adding photos into the middle of the text and other formatting, etc.
gem 'rails_12factor' #recommended by the heroku upload process, to "skip plugin injection"
gem 'fancybox2-rails' #for a beautiful lightbox when clicking and zooming on pictures
#gem 'turbolinks' #Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks

group :development, :test do #nominate for deletion, I don't test...
  gem 'rspec-rails', '2.9.0' #rspec
  gem 'guard-rspec', '0.5.5' #automatically run specs
end

gem 'annotate', '2.5.0', group: :development #this annotates models, routes, and fixtures based on database schema

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.4' #default added by RoR #asset compression
  gem 'coffee-rails', '3.2.2' #default added by RoR #asset compression
  gem 'uglifier', '1.2.3' #default added by RoR #asset compression
  gem 'asset_sync' #this is to get my static assets (at the time) to work on amazon s3... although i'm not sure what it does now)
  #gem 'rake'#, '0.8.7'

end

group :test do #nominate all these for deletion
  gem 'capybara', '1.1.2', :require => false 
  gem 'factory_girl_rails', '1.4.0', :require => false #more dynamic form testing
  gem 'cucumber-rails', '1.2.1', :require => false #more readable testing
  gem 'database_cleaner', '0.7.0'
  gem 'rb-fsevent', '0.9.1', :require => false
  gem 'growl', '1.0.3' #growlnotify bindings (huh?!?!)
  gem 'guard-spork', '0.3.2'  
  gem 'spork', '0.9.0' #forking drb spec server #what does that mean??
  gem 'launchy', '2.1.0' #cross-platform launching....not sure why I need this
end

group :production do
  #gem 'thin'
  gem 'unicorn' #speeds up website
  #gem 'asset_sync'
end

