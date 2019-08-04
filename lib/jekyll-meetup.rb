require 'jekyll/meetup/command'
require 'jekyll/meetup/version'

module Jekyll
  module Meetup
    autoload :ApiClient, 'jekyll/meetup/api_client'
    autoload :DataCollection, 'jekyll/meetup/data_collection'
  end
end
