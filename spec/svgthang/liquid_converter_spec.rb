require "spec_helper"

RSpec.describe SvgThang::LiquidConverter do
  describe "#convert" do
    it "generates liquid template from svg file" do
      if Dir.exist?("tmp/build")
        FileUtils.remove_dir("tmp/build")
      end
      FileUtils.mkdir_p("tmp/build")

      SvgThang::LiquidConverter
        .new(default_classes: "default-class")
        .convert("spec/fixtures/icon.svg", "tmp/build/icon.svg")

      svg_doc = Oga.parse_html(File.read("tmp/build/icon.svg"))
      svg_class = svg_doc.at_css("svg").get("class")

      expect(svg_class).to include "default-class"
      expect(svg_class).to include "{{ include.classes }}"
    end
  end
end
