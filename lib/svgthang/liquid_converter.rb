require "oga"
require "logger"

module SvgThang
  class LiquidConverter
    attr_reader :default_classes, :prefix, :logger

    def initialize(default_classes: "", prefix: "")
      @default_classes = default_classes
      @prefix = prefix
      @logger = Logger.new(STDOUT)
    end

    def convert(source_path, target_path)
      contents = File.read(source_path)

      if !contents.start_with? "<svg"
        logger.error "#{source_path} doesn't appear to be an SVG file"
        return
      end

      logger.info "Converting #{source_path} to Liquid template at #{target_path}"

      svg_doc = Oga.parse_html(contents)
      svg_doc.at_css("svg").set(
        "class", "#{default_classes} {{ include.classes }}")
      html = svg_doc.to_xml

      filename = "#{prefix}#{File.basename(target_path)}"
      new_target_path = Pathname.new(target_path).parent.join(filename)

      File.open(new_target_path, "w") do |f|
        f.write(html)
      end
    end
  end
end
