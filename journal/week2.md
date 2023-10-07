## Week 2 Bootcamp ReadMe

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.

It is the porimary way to install ruby packages (known as gems) for ruby.

####  Install Gems
You need to create a gemfile and define your gems in that file 

``` 
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

You then need to run the `buyndle install` command

This will install the gems ion the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be cretaed to lockd down the germ versions used in the project

### Sinatra

Is a micro web-framework for rubby to build web-apps.

It is great for mock or development servers for for very simple projects. You can create a web-server in a single file.

https://sinatrarb.com  


## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the server.rb file.



