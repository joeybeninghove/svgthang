require "spec_helper"

RSpec.describe SvgThang::ErbConverter do
  describe "#convert" do
    it "generates erb templates from svg files" do
      if Dir.exist?("tmp/build")
        FileUtils.remove_dir("tmp/build")
      end
      FileUtils.mkdir_p("tmp/build")

      SvgThang::ErbConverter
        .new(default_classes: "default-class")
        .convert("spec/fixtures/icon.svg", "tmp/build/icon.svg")

      svg_doc = Oga.parse_html(File.read("tmp/build/icon.html.erb"))
      svg_class = svg_doc.at_css("svg").get("class")

      expect(svg_class).to include "default-class"
      expect(svg_class).to include "<%= defined?(classes) ? classes : nil %>"
    end
  end

  context "file does not start with <svg" do
    it "skips the template generation" do
      if Dir.exist?("tmp/build")
        FileUtils.remove_dir("tmp/build")
      end
      FileUtils.mkdir_p("tmp/build")

      SvgThang::ErbConverter
        .new(default_classes: "default-class")
        .convert("spec/fixtures/bogus-icon.svg", "tmp/build/bogus-icon.svg")

      expect(File.exist?("tmp/build/bogus-icon.html.erb")).to be false
    end
  end
end
