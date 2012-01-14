# This file is used by Rack-based servers to start the application.
require 'rack/fiber_pool'
use Rack::FiberPool
require ::File.expand_path('../config/environment',  __FILE__)
run Kpsu::Application
