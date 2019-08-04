module Jekyll
  module Meetup
    class DataCollection
      def initialize(data_dir, collection_name)
        @data_dir = data_dir
        @collection_name = collection_name
        @path = File.join(data_dir, collection_name)
      end

      def remove_existing_files!
        File.delete(*Dir[File.join(@path, '*')])
      end

      def create_file(filename, &block)
        File.open(File.join(@path, filename), 'w', &block)
      end

      def create_symlink(to_file, link_name)
        File.link(File.join(@path, to_file), File.join(@path, link_name))
      end
    end
  end
end
