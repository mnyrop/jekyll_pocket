# jekyll_pocket

jekyll hook plugin for building a fully portable site 🎣💾👝

[![Gem Version](https://badge.fury.io/rb/jekyll_pocket.svg)](https://badge.fury.io/rb/jekyll_pocket) ![License](https://img.shields.io/badge/license-MIT-yellowgreen.svg) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com) [![Build Status](https://travis-ci.org/mnyrop/jekyll_pocket.svg?branch=master)](https://travis-ci.org/mnyrop/jekyll_pocket) [![](https://img.shields.io/librariesio/github/mnyrop/jekyll_pocket.svg)](https://libraries.io/github/mnyrop/jekyll_pocket)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll_pocket'
```

Then execute:

```sh
$ bundle
```

And add it as a jekyll plugin in your `_config.yml` file

```yaml
plugins:
    - jekyll_pocket
```

## Usage

Make sure all of your files are using file extensions by setting `permalink: none` in your `_config.yml` file and looking through any custom page-level permalinks.

Then run jekyll build in pocket mode with:

```
$ bundle exec jekyll build JEKYLL_ENV=pocket
```

When the build is finished, you should be able to double click on your compiled index.html page and open up a fully functioning, serverless site in your browser. The links are all relative so you can move the site onto a thumbdrive and share it offline however you like.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JekyllPocket project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jekyll_pocket/blob/master/CODE_OF_CONDUCT.md).
