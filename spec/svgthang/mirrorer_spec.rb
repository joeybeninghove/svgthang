require "spec_helper"

RSpec.describe SvgThang::Mirrorer do
  describe "#mirror" do
    context "no sub-dirs" do
      it "generates liquid templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        svg_dir_root = Pathname.new("spec/fixtures/no-sub-dirs")
        output_dir_root = Pathname.new("tmp/build/foo")

        SvgThang::Mirrorer
          .new(output_dir: output_dir_root.to_s)
          .mirror(dir: svg_dir_root.to_s)

        expect(Dir.exist?("tmp/build/foo")).to be true
        expect(Dir.exist?("tmp/build/foo/no-sub-dirs")).to be true
      end
    end

    context "one-level of sub-dirs" do
      it "generates liquid templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        svg_dir_root = Pathname.new("spec/fixtures/one-level-sub-dirs")
        output_dir_root = Pathname.new("tmp/build/foo")

        SvgThang::Mirrorer
          .new(output_dir: output_dir_root.to_s)
          .mirror(dir: svg_dir_root.to_s)

        expect(Dir.exist?("tmp/build/foo")).to be true
        expect(Dir.exist?("tmp/build/foo/one-level-sub-dirs")).to be true
        expect(Dir.exist?("tmp/build/foo/one-level-sub-dirs/brands")).to be true
        expect(Dir.exist?("tmp/build/foo/one-level-sub-dirs/solid")).to be true
      end
    end

    describe "deeply nested svg files" do
      it "generates liquid templates from svg files" do
        if Dir.exist?("tmp/build")
          FileUtils.remove_dir("tmp/build")
        end

        svg_dir_root = Pathname.new("spec/fixtures/deep")
        output_dir_root = Pathname.new("tmp/build/foo")

        SvgThang::Mirrorer
          .new(output_dir: output_dir_root.to_s)
          .mirror(dir: svg_dir_root.to_s)

        expect(Dir.exist?("tmp/build/foo")).to be true
        expect(Dir.exist?("tmp/build/foo/deep")).to be true
        expect(Dir.exist?("tmp/build/foo/deep/some")).to be true
        expect(Dir.exist?("tmp/build/foo/deep/some/deeply")).to be true
        expect(Dir.exist?("tmp/build/foo/deep/some/deeply/nested")).to be true
        expect(Dir.exist?("tmp/build/foo/deep/some/deeply/nested/thing")).to be true
      end
    end
  end
end
