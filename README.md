# ActiveRecord::FilterWithScope
Rubygem that enables Rails ActiveRecord to Filter records out of the box. The handy tool that lets you filter your ActiveRecord models using the scopes you have already defined.

All you need to do is map the filter parameters to the corresponding scopes in the setup, and then call the filter class method on your model.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add active_record-filter_with_scope

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install active_record-filter_with_scope

## Usage

```ruby
    # models/post.rb
    class Post < ApplicationRecord
        scope :with_title, ->(title) { where(...) }
        scope :no_later_than, ->(moment) { where(...) }
        scope :with_read, { ... }

        # Use a block to override
        filter_with filter_keys: %i[title viewed created_at], scope_prefix: "with_" do |scope_for|
            scope_for.created_at = :no_later_than
            scope_for.viewed = :with_read
        end

        # Variants:

        # variant 1 - with scope_prefix, without block
        # scope :with_title, ->(title) { where(...) }
        # scope :with_created_at, ->(moment) { where(...) }
        # filter_with filter_keys: %i[title created_at], scope_prefix: "with_"

        # variant 2 - without scope_prefix
        # scope :with_title, ->(title) { where(...) }
        # scope :with_created_at, ->(moment) { where(...) }
        # filter_with filter_keys: %i[title created_at]
    end

    # controllers/posts_controller.rb
    class PostsController < ApplicationController
        def index
            @posts = Post.filter(filter_params)
            # Variants
            # @posts = Post.filter(filter_params, starting_query: Post.paginate(...))
            # @posts = Post.filter(filter_params, starting_query: Post.all)
        end
    end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment. To run the test suite, simply call `bin/test`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OmoleOO/active_record-filter_with_scope. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/OmoleOO/active_record-filter_with_scope/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveRecord::FilterWithScope project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_record-filter_with_scope/blob/main/CODE_OF_CONDUCT.md).


## Contact
Might be open to work, please feel free to reach out to me on [LinkedIn](https://linkedin.com/in/omoleoo)
