require 'net/http'
require 'json'

module Jekyll
  module Meetup
    # Simple API client for Meetup since there doesn't seem to be an open source
    # one that supports OAuth.
    class ApiClient
      API_BASE = URI('https://api.meetup.com')

      def self.events(urlname)
        request_uri = API_BASE + format('%<urlname>s/events', urlname: urlname)
        request_uri.query = URI.encode_www_form(
          scroll: 'next_upcoming'
        )

        body = Net::HTTP.get(request_uri)
        JSON.parse(body)
      end
    end
  end
end
