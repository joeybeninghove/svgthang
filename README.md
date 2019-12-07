# SvgThang

For those times when you want to use inline SVGs so they can be styled with CSS, this little utility allows you to convert SVG files into different kinds of templates, such as ERB partials or Liquid templates.

The main reason I built this tool was to generate SVG templates for all of the FontAwesome SVG icons that could be rendered inline and styled via CSS classes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'svgthang'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install svgthang

## Usage

```bash
Usage: svgthang [options]
    -s, --source-dir SOURCE_DIR      Source directory of SVG files
    -o, --output-dir OUTPUT_DIR      Output directory
    -f, --format FORMAT              Output format (erb, liquid)
    -c, --classes DEFAULT_CLASSES    Default CSS classes for each generated SVG element
    -p, --prefix FILE_PREFIX         Prefix to give output files (example: _ for ERB partials)
    -h, --help                       Show help
```

### ERB Partials

You can generate ERB partials from SVG icons that can then be rendered in a Rails app and passed a `classes` argument as a string to give the `<svg>` element custom CSS classes.

```bash
svgthang --source-dir icons/fa --output-dir build/icons --format erb --classes fill-current --prefix _

# generates
# build/icons/fa/_icon1.html.erb
# build/icons/fa/_icon2.html.erb
# build/icons/fa/_icon3.html.erb
```

The contents of these partials would look something like this:

```erb
<!-- build/icons/fa/_icon1.html.erb -->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="fill-current <%= defined?(classes) ? classes : nil %>"><path></path></svg>
```

Then to render this partial in a Rails app, you could do the following:
```erb
<%= render "icons/fa/icon1", classes: "width-4 height-4 margin-right-4" %>
```

### Liquid Templates

Similarly, you can also generate configurable Liquid templates that can be included and passed custom CSS classes.

```bash
svgthang --source-dir icons/fa --output-dir build/icons --format liquid --classes fill-current

# generates
# build/icons/fa/icon1.svg
# build/icons/fa/icon2.svg
# build/icons/fa/icon3.svg
```

The contents of these SVG files would look something like this:

```html
<!-- build/icons/fa/icon1.svg -->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="fill-current {{ include.classes }}"><path></path></svg>
```

Then to include this SVG template in something like Jekyll, you can do something like this:
```liquid
{% include icons/fa/icon1.svg classes="h-8 w-8" %}
```

## How It Works

What makes this especially powerful is if you want to convert something like the entire set of FontAwesome icons into these configurable templates all at once.

When you run `svgthang`, it will look to mirror the `source-dir` completely into the `output-dir` (recursively), so if you downloaded the FontAwesome SVGs into a directory structure something like this:

```bash
icons/fa
|- brands
  |- github.svg
  |- linkedin.svg
|- regular
  |- acorn.svg
  |- ad.svg
|- solid
  |- acorn.svg
  |- ad.svg
```

And you ran `svgthang --source-dir icons/fa --output-dir build/icons`

It would generate the following in the output dir:
```bash
build/icons/fa
|- brands
  |- github.svg
  |- linkedin.svg
|- regular
  |- acorn.svg
  |- ad.svg
|- solid
  |- acorn.svg
  |- ad.svg
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joeybeninghove/svgthang. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SvgThang project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joeybeninghove/svgthang/blob/master/CODE_OF_CONDUCT.md).
