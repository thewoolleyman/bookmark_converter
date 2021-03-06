#!/usr/bin/env ruby

# Copy this file into a dir containing *.URL files with lines like "URL=..." and pipe the output to a html file
# chmod a+x convert_bookmarks.rb
# ./convert_bookmarks.rb > my_bookmarks.html

files = Dir.entries(File.expand_path(File.dirname(__FILE__)))
files.reject! {|f| f == '.' or f == '..'}
files.reject! {|f| File.directory?(f)}
files.sort!
urls = []
files.each do |file|
  io = File.new(file)
  lines = io.readlines
  lines = lines.map {|l| l.chomp}
  line = lines.detect {|l| l =~ /^URL=/}
  next if line.nil?
  line =~ /^URL=(.*)/
  urls << $1
end
output_page = "<html>\n<body>\n"
urls.each do |url|
  output_page += "<p><a href=\"#{url}\">#{url}</a></p>\n"
end
output_page += "</body>\n</html>\n"
print output_page