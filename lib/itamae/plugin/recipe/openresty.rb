require 'itamae/plugin/recipe/openresty/version'

module Itamae
  module Plugin
    module Recipe
      module Openresty
        DEFAULT_VERSION = '1.7.4.1'.freeze

        DEFAULT_PACKAGES = {
          ubuntu: [
            'perl',
            'make',
            'wget',
            'libreadline-dev',
            'libssl-dev',
            'libpcre3-dev',
            'libncurses5-dev',
          ],
          centos: [
            'make',
            'wget',
            'readline-devel',
            'openssl-devel',
            'pcre-devel,'
          ]
        }.freeze

        DEFAULT_CONFIGURE_FLAGS = {
          'prefix'                       => '/opt',
          'with-lua51'                   => nil,
          'with-luajit'                  => nil,
          'with-pcre-jit'                => nil,
          'with-http_gzip_static_module' => nil,
          'user'                         => 'nginx',
          'group'                        => 'nginx',
        }.freeze

        DEFAULT_INIT_SCRIPT_PATH = '/etc/init.d/openresty'

        BUILD_WORKING_DIR = '/tmp/openresty'

        def self.extract_metadata(node)
          raw = node['openresty'] || {}

          metadata = {}
          metadata[:version]                 = raw['version'] || DEFAULT_VERSION
          metadata[:archive_url]             = raw['archive_url'] || "http://openresty.org/download/ngx_openresty-#{metadata[:version]}.tar.gz"
          metadata[:work_dir]                = raw['work_dir'] || BUILD_WORKING_DIR
          metadata[:configure_flags]         = self.extract_configure_flags(raw['configure_flags'])
          metadata[:install_depends_package] = raw['install_depends_package'] || true

          metadata
        end

        def self.extract_configure_flags(options)
          if options.nil?
            options = DEFAULT_CONFIGURE_FLAGS.dup
          end

          options.map do |key, value|
            if value.nil?
              "--#{key}"
            else
              "--#{key}=#{value}"
            end
          end
        end

        def self.extract_init_script_options(node)
          raw = node['openresty'] || {}
          configure_flags = raw['configure_flags'] || DEFAULT_CONFIGURE_FLAGS
          {
            prefix: configure_flags['configure_flags'] || DEFAULT_CONFIGURE_FLAGS['prefix'],
            sbin_path: self.sbin_path(node),
            config_path: configure_flags['config-path'] || DEFAULT_CONFIGURE_FLAGS['prefix'] + '/nginx/conf/nginx.conf',
            pid_path: configure_flags['pid-path'] || DEFAULT_CONFIGURE_FLAGS['prefix'] + '/nginx/logs/nginx.pid',
            init_script_path: raw['init_script_path'] || DEFAULT_INIT_SCRIPT_PATH
          }
        end

        def self.sbin_path(node)
          raw = node['openresty'] || {}
          configure_flags = raw['configure_flags'] || DEFAULT_CONFIGURE_FLAGS
          configure_flags['sbin-path'] || DEFAULT_CONFIGURE_FLAGS['prefix'] + '/nginx/sbin/nginx'
        end
      end
    end
  end
end
