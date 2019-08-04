require 'json'
require 'yaml'
require 'net/https'

def filenamify(str)
  str.strip.downcase.gsub(/[^a-z]+/, '-')
end

module Jekyll
  module Meetup
    # Add the `jekyll meetup` command which downloads from Meetup.
    class Command < Jekyll::Command
      class << self
        def init_with_program(prog)
          prog.command(:meetup) do |c|
            c.syntax 'meetup download'
            c.description 'Downloads events from meetup'
            c.action do |args, options|
              config = configuration_from_options(options)
              validate_command!(args, options, config)
              case args[0]
              when 'download'
                process_download(config)
              end
            end
          end
        end

        def validate_command!(args, options, config)
          # future-proof against other options like OAuth setup:
          raise '`jekyll meetup` must be called with the download argument' \
            unless args[0] == 'download'

          # ensure required config is there:
          raise 'No meetup.urlname found in config file.' \
            unless config['meetup']['urlname']
          raise 'No meetup.colleciton_name found in config file.' \
            unless config['meetup']['collection_name']
        end

        def process_download(config)
          collection = DataCollection.new(
            config['data_dir'],
            config['meetup']['collection_name']
          )
          collection.remove_existing_files!

          Meetup::ApiClient
            .events(config['meetup']['urlname'])
            .each_with_index do |event, i|
            filename = format(
              '%<date>s-%<name>s.yml',
              name: filenamify(event['name']),
              date: event['local_date']
            )

            collection.create_file(filename) { |f| f.puts YAML.dump(event) }
            collection.create_symlink(filename, 'upcoming.yml') if i.zero?
          end
        end
      end
    end
  end
end
