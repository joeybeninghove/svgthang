lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "svgthang/version"

Gem::Specification.new do |spec|
  spec.name          = "svgthang"
  spec.version       = SvgThang::VERSION
  spec.authors       = ["Joey Beninghove"]
  spec.email         = ["me@joey.io"]

  spec.summary       = %q{Ain't nuthin' but a SVG thang, baby}
  spec.description   = %q{Tool for converting SVGs to other formats like ERB partials or Liquid templates}
  spec.homepage      = "https://joey.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/joeybeninghove/svgthang"
    spec.metadata["changelog_uri"] = "https://github.com/joeybeninghove/svgthang/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "oga", "~> 3.0"
  spec.add_dependency "htmlentities", "~> 4.3"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "byebug", "~> 11.0"
end
