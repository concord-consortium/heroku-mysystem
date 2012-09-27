# This file is used by Rack-based servers to start the application.

  
require ::File.expand_path('../config/environment',  __FILE__)
use Rack::ReverseProxy do 
  # Set :preserve_host to true globally (default is true already)
  reverse_proxy_options :preserve_host => true

  # Forward the path /test* to http://example.com/test*
  reverse_proxy '/mysystem_designs', 'http://couchdb.cosmos.concord.org/'

  # # Forward the path /foo/* to http://example.com/bar/*
  # reverse_proxy /^\/foo(\/.*)$/, 'http://example.com/bar$1', :username => 'name', :password => 'basic_auth_secret'
end

run MsAuthoring::Application
