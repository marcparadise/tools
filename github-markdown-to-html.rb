#!/usr/bin/env ruby

# A simple tool that converts github-flavored markdown to HTML, so that you can preview 
# markdown changes before pushing them. 
# 
#
# Requires gem: github-markdown
require 'github/markdown'

ARGV.each do |a|
    File.open("#{a}.html", "w") {|f| f.write(GitHub::Markdown.render(File.read(a))) }
    system("open #{a}.html")
end
