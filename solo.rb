require 'pathname'

file_cache_path "#{ Pathname.new(File.expand_path(__FILE__)) + '..' + 'tmp' }"
cookbook_path   "#{ Pathname.new(File.expand_path(__FILE__)) + '..' + 'cookbooks' }"
json_attribs	"#{ Pathname.new(File.expand_path(__FILE__)) + '..' + 'roles/default.json' }"
log_level       :info
log_location    STDOUT
ssl_verify_mode :verify_none
