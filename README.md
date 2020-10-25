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

## Development

After checking out the repo, run `bundle install`.
Then, run `rake spec` to run the tests.

You can run the binary locally with: `ruby -Ilib ./exe/asdf-discover path/to/directory`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jmks/asdf-discover.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
