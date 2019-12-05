require "spec_helper"

RSpec.describe "integration" do
  describe "converting svgs to erb templates" do
    context "no dirs" do
      it "generates erb templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        SvgThang::Mirrorer
          .new(output_dir: "tmp/build/erb")
          .mirror(dir: "spec/fixtures/no-sub-dirs") do |source_path, target_path|
          SvgThang::ErbConverter
            .new(default_classes: "default-class")
            .convert(source_path, target_path)
        end

        [
          "tmp/build/erb/no-sub-dirs/icon1.html.erb",
          "tmp/build/erb/no-sub-dirs/icon2.html.erb"
        ].each do |path|
          svg_doc = Oga.parse_html(File.read(path))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "<%= defined?(classes) ? classes : nil %>"
        end
      end
    end

    context "one-level of dirs" do
      it "generates erb templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        SvgThang::Mirrorer
          .new(output_dir: "tmp/build/erb")
          .mirror(dir: "spec/fixtures/one-level-sub-dirs") do |source_path, target_path|
          SvgThang::ErbConverter
            .new(default_classes: "default-class")
            .convert(source_path, target_path)
        end

        [
          "tmp/build/erb/one-level-sub-dirs/brands/500px.html.erb",
          "tmp/build/erb/one-level-sub-dirs/solid/abacus.html.erb"
        ].each do |path|
          svg_doc = Oga.parse_html(File.read(path))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "<%= defined?(classes) ? classes : nil %>"
        end
      end
    end

    describe "deeply nested svg files" do
      it "generates erb templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        SvgThang::Mirrorer
          .new(output_dir: "tmp/build/erb")
          .mirror(dir: "spec/fixtures/deep") do |source_path, target_path|
          SvgThang::ErbConverter
            .new(default_classes: "default-class")
            .convert(source_path, target_path)
        end

        [
          "tmp/build/erb/deep/some/deeply/icon.html.erb",
          "tmp/build/erb/deep/some/deeply/nested/icon.html.erb",
          "tmp/build/erb/deep/some/deeply/nested/thing/icon.html.erb"
        ].each do |path|
          svg_doc = Oga.parse_html(File.read(path))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "<%= defined?(classes) ? classes : nil %>"
        end
      end
    end
  end

  describe "converting svgs to liquid templates" do
    context "no dirs" do
      it "generates liquid templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        svg_dir_root = Pathname.new("spec/fixtures/no-sub-dirs")
        liquid_dir_root = Pathname.new("tmp/build/liquid")

        SvgThang::Mirrorer
          .new(output_dir: liquid_dir_root.to_s)
          .mirror(dir: svg_dir_root.to_s) do |source_path, target_path|
          SvgThang::LiquidConverter
            .new(default_classes: "default-class")
            .convert(source_path, target_path)
        end

        [
          "tmp/build/liquid/no-sub-dirs/icon1.svg",
          "tmp/build/liquid/no-sub-dirs/icon2.svg"
        ].each do |path|
          svg_doc = Oga.parse_html(File.read(path))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "{{ include.classes }}"
        end
      end
    end

    context "one-level of dirs" do
      it "generates liquid templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        svg_dir_root = Pathname.new("spec/fixtures/one-level-sub-dirs")
        liquid_dir_root = Pathname.new("tmp/build/liquid")

        SvgThang::Mirrorer
          .new(output_dir: liquid_dir_root.to_s)
          .mirror(dir: svg_dir_root.to_s) do |source_path, target_path|
          SvgThang::LiquidConverter
            .new(default_classes: "default-class")
            .convert(source_path, target_path)
        end

        [
          "tmp/build/liquid/one-level-sub-dirs/brands/500px.svg",
          "tmp/build/liquid/one-level-sub-dirs/solid/abacus.svg"
        ].each do |path|
          svg_doc = Oga.parse_html(File.read(path))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "{{ include.classes }}"
        end
      end
    end

    describe "deeply nested svg files" do
      it "generates liquid templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        svg_dir_root = Pathname.new("spec/fixtures/deep")
        liquid_dir_root = Pathname.new("tmp/build/liquid")

        SvgThang::Mirrorer
          .new(output_dir: liquid_dir_root.to_s)
          .mirror(dir: svg_dir_root.to_s) do |source_path, target_path|
          SvgThang::LiquidConverter
            .new(default_classes: "default-class")
            .convert(source_path, target_path)
        end

        [
          "tmp/build/liquid/deep/some/deeply/icon.svg",
          "tmp/build/liquid/deep/some/deeply/nested/icon.svg",
          "tmp/build/liquid/deep/some/deeply/nested/thing/icon.svg"
        ].each do |path|
          svg_doc = Oga.parse_html(File.read(path))
          svg_class = svg_doc.at_css("svg").get("class")

          expect(svg_class).to include "default-class"
          expect(svg_class).to include "{{ include.classes }}"
        end
      end
    end
  end
end
