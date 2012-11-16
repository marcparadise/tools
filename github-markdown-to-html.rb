#!/usr/bin/env ruby

require 'github/markdown'

ARGV.each do |a|
    File.open("#{a}.html", "w") {|f| f.write(GitHub::Markdown.render(File.read(a))) }
end
