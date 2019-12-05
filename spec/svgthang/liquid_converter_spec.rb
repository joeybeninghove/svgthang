require "spec_helper"

RSpec.describe SvgThang::LiquidConverter do
  describe "#convert" do
    it "does something" do
      if Dir.exist?("tmp/build")
        FileUtils.remove_dir("tmp/build")
      end

      svg_dir_root = Pathname.new("spec/fixtures/fa")
      liquid_dir_root = Pathname.new("tmp/build/liquid")

      SvgThang::LiquidConverter
        .new(build_dir: liquid_dir_root.to_s, default_classes: "default-class")
        .convert(svg_dir_root.to_s)

      Dir.each_child(liquid_dir_root) do |dir_name|
        liquid_dir_path = Pathname.new(liquid_dir_root.join(dir_name))

        Dir.each_child(liquid_dir_path.to_s) do |filename|
          svg_doc = Oga.parse_html(File.read(liquid_dir_path.join(filename)))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "{{ include.classes }}"
        end 
      end
    end
  end
end
