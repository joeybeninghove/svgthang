require "oga"

module SvgThang
  class ErbConverter
    attr_reader :default_classes

    def initialize(default_classes: "")
      @default_classes = default_classes
    end

    def convert(source_path, target_path)
      svg_doc = Oga.parse_html(File.read(source_path))
      svg_doc.at_css("svg").set(
        "class", "#{default_classes} <%= defined?(classes) ? classes : nil %>")
      html = svg_doc.to_xml.gsub("&lt;", "<").gsub("&gt;", ">")

      filename = "#{File.basename(target_path, ".svg")}.html.erb"
      new_target_path = Pathname.new(target_path).parent.join(filename)

      File.open(new_target_path, "w") do |f|
        f.write(html)
      end
    end
  end
end
