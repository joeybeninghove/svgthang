require "svgthang/version"

module SvgThang
  class Error < StandardError; end

  class Foo
    def self.bar
    end
  end
end

require "svgthang/erb_converter"
require "svgthang/liquid_converter"
