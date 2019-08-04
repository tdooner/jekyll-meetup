require 'jekyll/meetup/command'
require 'jekyll/meetup/version'

module Jekyll
  # The top-level module for the gem.
  module Meetup
    autoload :ApiClient, 'jekyll/meetup/api_client'
    autoload :DataCollection, 'jekyll/meetup/data_collection'
  end
end
