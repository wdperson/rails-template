# Delete unneeded files
run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/robots.txt'
run 'rm -f public/javascripts/*'

# Prepare .gitignore files
run 'touch tmp/.gitignore log/.gitignore vendor/.gitignore'
append_file '.gitignore', <<-END
.DS_Store
log/*.log
tmp/**/*
db/*.sqlite3
coverage/*
public/system/**/*
END

# Set up git repository
git :init
git :add => '.'

#download jquery.js
run "curl -s -L http://code.jquery.com/jquery-1.4.4.js > public/javascripts/jquery.js"

append_file 'Gemfile', <<-END

group :cucumber do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'rspec-rails'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end
END

#get the gems installed if they aren't already
run "bundle install"

#set up cucumber
run "rails g cucumber:install --rspec --capybara"

git :add => '.'
git :commit => "-a -m 'Initial Commit'"
