require "oga"

module SvgThang
  class LiquidConverter
    attr_reader :default_classes

    def initialize(default_classes: "")
      @default_classes = default_classes
    end

    def convert(source_path, target_path)
      svg_doc = Oga.parse_html(File.read(source_path))
      svg_doc.at_css("svg").set(
        "class", "#{default_classes} {{ include.classes }}")
      html = svg_doc.to_xml.gsub("&lt;", "<").gsub("&gt;", ">")

      File.open(target_path, "w") do |f|
        f.write(html)
      end
    end
  end
end
