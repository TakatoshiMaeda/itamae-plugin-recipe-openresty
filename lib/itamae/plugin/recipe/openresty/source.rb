require 'itamae/plugin/recipe/openresty'

metadata = Itamae::Plugin::Recipe::Openresty.extract_metadata(node)

if metadata[:install_depends_package]
  Itamae::Plugin::Recipe::Openresty::DEFAULT_PACKAGES[os[:family].to_sym].each do |pkg|
    package pkg
  end
end

execute 'create openresty install working directory' do
  command "mkdir -p #{metadata[:work_dir]}"
end

execute 'download openresty archive file' do
  command "wget #{metadata[:archive_url]} -O #{metadata[:work_dir]}/openresty.tar.gz"
  not_if "test #{metadata[:work_dir]}/openresty.tar.gz"
end

execute 'unzip openresty' do
  command "tar xvfz #{metadata[:work_dir]}/openresty.tar.gz -C #{metadata[:work_dir]}"
  not_if "test #{metadata[:work_dir]}/ngx_openresty-#{metadata[:version]}"
end

execute 'build openresty' do
  command "cd #{metadata[:work_dir]}/ngx_openresty-#{metadata[:version]} && ./configure #{metadata[:configure_flags].join(' ')} && make && make install"
  unless ENV['OPENRESTY_REBUILD'] != nil
    not_if "test #{Itamae::Plugin::Recipe::Openresty.sbin_path(node)}"
  end
end

init_script_options = Itamae::Plugin::Recipe::Openresty.extract_init_script_options(node)
template init_script_options[:init_script_path] do
  source 'assets/openresty.init.erb'
  action :create
  variables(init_script_options)
end

execute 'setup openresty init script' do
  command "chmod +x #{init_script_options[:init_script_path]}"
  only_if "test #{init_script_options[:init_script_path]}"
end

service 'openresty' do
  name   init_script_options[:init_script_path].split('/').last
  action :enable
end
