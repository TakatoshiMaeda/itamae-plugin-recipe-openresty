# Itamae::Plugin::Recipe::Openresty

Itamae plugin to install [OpenResty](https://openresty.org/) with init scripts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-openresty'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-openresty

## Usage

Write a following line to your itamae recipe.

```rb
# recipe.rb

# Install openresty from source
include_recipe 'openresty::source'
service 'openresty'
```

Execute it with: `itamae ssh -h ... recipe.rb`.

```yml
# node.yml
openresty:
  version: 1.11.2.1
  archive_url: https://openresty.org/download/openresty-1.11.2.1.tar.gz
  work_dir: /tmp/openresty
  install_depends_package: true
  configure_flags:
    prefix: /opt
    with-lua51:
    with-luajit:
    with-pcre-jit:
    with-http_gzip_static_module:
    user: nginx
    group: nginx
    config-path: /opt/nginx/conf/nginx.conf
    pid-path: /opt/nginx/logs/nginx.pid
    sbin-path: /opt/nginx/sbin/nginx
```

## Contributing

1. Fork it ( https://github.com/TakatoshiMaeda/itamae-plugin-recipe-openresty/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
