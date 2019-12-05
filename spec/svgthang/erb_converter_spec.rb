require "spec_helper"

RSpec.describe SvgThang::ErbConverter do
  describe "#convert" do
    it "does something" do
      if Dir.exist?("tmp/build")
        FileUtils.remove_dir("tmp/build")
      end

      svg_dir_root = Pathname.new("spec/fixtures/fa")
      erb_dir_root = Pathname.new("tmp/build/erb")

      SvgThang::ErbConverter
        .new(build_dir: erb_dir_root.to_s, default_classes: "default-class")
        .convert(svg_dir_root.to_s)

      Dir.each_child(erb_dir_root) do |dir_name|
        erb_dir_path = Pathname.new(erb_dir_root.join(dir_name))

        Dir.each_child(erb_dir_path.to_s) do |filename|
          svg_doc = Oga.parse_html(File.read(erb_dir_path.join(filename)))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "<%= defined?(classes) ? classes : nil %>"
        end 
      end
    end
  end
end
