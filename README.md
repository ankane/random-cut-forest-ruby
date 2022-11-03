# Random Cut Forest Ruby

[Random Cut Forest](https://github.com/aws/random-cut-forest-by-aws) (RCF) anomaly detection for Ruby

[![Build Status](https://github.com/ankane/random-cut-forest-ruby/workflows/build/badge.svg?branch=master)](https://github.com/ankane/random-cut-forest-ruby/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "rcf"
```

## Getting Started

Create a forest with 3 dimensions

```ruby
forest = Rcf::Forest.new(3)
```

Score a point

```ruby
forest.score([1.0, 2.0, 3.0])
```

Update with a point

```ruby
forest.update([1.0, 2.0, 3.0])
```

## Example

```ruby
forest = Rcf::Forest.new(3)

200.times do |i|
  point = [rand, rand, rand]

  # make the second to last point an anomaly
  if i == 198
    point[1] = 2
  end

  score = forest.score(point)
  puts "point = #{i}, score = #{score}"
  forest.update(point)
end
```

## Reference

- [Robust Random Cut Forest Based Anomaly Detection On Streams](https://proceedings.mlr.press/v48/guha16.pdf)

## History

View the [changelog](CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/random-cut-forest-ruby/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/random-cut-forest-ruby/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/random-cut-forest-ruby.git
cd random-cut-forest-ruby
bundle install
bundle exec rake vendor:all
bundle exec rake test
```
