# asdf-discover

A gem that provides an executable to populate [asdf](http://asdf-vm.com/)'s `.tool-versions` file.

## Changelog

[Changelog](./CHANGELOG.md) following https://keepachangelog.com

## Installation

```
$ gem install asdf-discover
```

## Usage

Run `asdf-discover` in a project directory.

## Languages / Versions Discovered

| Lanuage | File          |
|---------|---------------|
| Go      | go.mod        |
| Ruby    | .ruby-version |
| Ruby    | .rvmrc        |
| node.js | .nvmrc        |
| node.js | .node-version |

## TODO

* If a version comes from multiple sources, list them all (currently displays the first found)
* Select a version from `asdf list tool` for versions specified with a requirement, e.g. "~> 1.10"
* There seems to be 2 ways to find a version:
  * The contents of a file (e.g. .ruby-version)
  * A line in a file (e.g. go.mod)

  Consider a DSL for adding more:

  ```ruby
  class GoMod
    include Asdf::Searcher

    scan_file "go.mod", for: /go ([0-9.]+)$/
  end

  class DotRubyVersion
    include Asdf::Searcher

    file_contents ".ruby-version"
  end
  ```

## Development

After checking out the repo, run `bundle install`.
Then, run `rake spec` to run the tests.

You can run the binary locally with: `ruby -Ilib ./exe/asdf-discover path/to/directory`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jmks/asdf-discover.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
