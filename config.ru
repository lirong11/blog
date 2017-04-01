# This file is used by Rack-based servers to start the application.



# run Blog::API


require ::File.expand_path('../config/environment',  __FILE__)
run Blog::Application


