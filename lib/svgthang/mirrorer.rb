require "oga"
require "pathname"

module SvgThang
  class Mirrorer
    attr_reader :output_dir

    def initialize(output_dir:)
      @output_dir = output_dir
    end

    def mirror(dir:, &each_file)
      FileUtils.mkdir_p Pathname.new(output_dir).join(File.basename(dir))
      mirror_children(dir, File.basename(dir), &each_file)
    end

    private

    def mirror_children(source_path, parent_path="", &each_file)
      Dir.each_child(source_path).each do |child|
        child_path = Pathname.new(source_path).join(child)
        target_path = Pathname.new(output_dir).join(parent_path).join(child)

        if File.directory? child_path
          FileUtils.mkdir_p target_path
          mirror_children(child_path, Pathname.new(parent_path).join(child), &each_file)
        else
          each_file.call(child_path, target_path) if each_file
        end
      end
    end
  end
end
