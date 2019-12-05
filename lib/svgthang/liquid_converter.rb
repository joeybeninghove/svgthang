require "oga"

module SvgThang
  class LiquidConverter
    attr_reader :default_classes

    def initialize(default_classes: "")
      @default_classes = default_classes
    end

    def convert(source_path, target_path)
      contents = File.read(source_path)

      if !contents.start_with? "<svg"
        puts "#{source_path} doesn't appear to be an SVG file"
        return
      end

      puts "Converting #{source_path} to Liquid template at #{target_path}"

      svg_doc = Oga.parse_html(contents)
      svg_doc.at_css("svg").set(
        "class", "#{default_classes} {{ include.classes }}")
      html = svg_doc.to_xml

      File.open(target_path, "w") do |f|
        f.write(html)
      end
    end
  end
end
