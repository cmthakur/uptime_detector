require 'sinatra'
require 'httparty'
require 'sinatra/base'
require File.dirname(__FILE__) + '/lib/watch_dog'

# load Directory
Dir[File.dirname(__FILE__) + '/lib/*.rb'].sort.each {|file| require file}

module SiteUp
  class App < Sinatra::Base
    get '/' do
      apps = UpTimeRobot.new(ENV['api_key']).watch
      haml :index, locals: { apps: apps }
    end

    # If you are not using shogun gem, use run!
    # run!
  end
end

