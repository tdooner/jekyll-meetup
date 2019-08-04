module Jekyll
  module Meetup
    class DataCollection
      def initialize(data_dir, collection_name)
        @data_dir = data_dir
        @collection_name = collection_name
        @path = File.join(data_dir, collection_name)
        @directories_created = false
      end

      def remove_existing_files!
        File.delete(*Dir[File.join(@path, '*')])
      end

      def create_file(filename, &block)
        create_directories unless @directories_created

        File.open(File.join(@path, filename), 'w', &block)
      end

      def create_symlink(to_file, link_name)
        create_directories unless @directories_created

        File.link(File.join(@path, to_file), File.join(@path, link_name))
      end

      private

      def create_directories
        Dir.mkdir(@data_dir) unless Dir.exist?(@data_dir)

        unless Dir.exist?(File.join(@data_dir, @collection_name))
          Dir.mkdir(File.join(@data_dir, @collection_name))
        end

        @directories_created = true
      end
    end
  end
end
