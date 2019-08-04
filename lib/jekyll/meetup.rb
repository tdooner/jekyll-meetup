require "jekyll/meetup/version"

module Jekyll
  module Meetup
    class DownloadCommand < Jekyll::Command
      class << self
        def init_with_program(prog)
          require 'pry'; binding.pry
          prog.command(:meetup) do |c|
            c.syntax 'download'
            c.description 'Downloads events from meetup'
            c.option "foo", "-f foo", "foo"
            c.action do |args, options|
              require 'pry'; binding.pry
            end
          end
        end
      end
    end
  end
end
