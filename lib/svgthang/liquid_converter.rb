require "oga"

module SvgThang
  class LiquidConverter
    attr_reader :build_dir, :default_classes

    def initialize(build_dir: "build/liquid", default_classes: "")
      @build_dir = build_dir
      @default_classes = default_classes
    end

    def convert(svg_dir)
      FileUtils.mkdir_p build_dir

      Dir.each_child(svg_dir).each do |dir_name|
        svg_dir_path = Pathname.new(svg_dir).join(dir_name)
        liquid_dir_path = Pathname.new(build_dir).join(dir_name)

        FileUtils.mkdir liquid_dir_path

        Dir.each_child(svg_dir_path) do |filename|  
          svg_doc = Oga.parse_html(File.read(svg_dir_path.join(filename)))
          svg_doc.at_css("svg").set(
            "class", "#{default_classes} {{ include.classes }}")
          html = svg_doc.to_xml.gsub("&lt;", "<").gsub("&gt;", ">")

          File.open(liquid_dir_path.join(filename), "w") do |f|
            f.write(html)
          end
        end
      end
    end
  end
end
