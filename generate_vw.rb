#!/usr/bin/env ruby
require 'bundler/setup'
require 'walker_method'
require 'ruby-progressbar'
require 'logger'
require 'json'

items = []
weights = []

progressbar = ProgressBar.create(:total => nil, :format => '%t: %c |%B|', :throttle_rate => 0.1, :output => STDERR)
File.foreach('combined/counts.txt') do |line|
  parts = line.chomp.strip.split(/\s+/)
  items << parts[1]
  weights << parts[0].to_i
  progressbar.increment
end
progressbar.total = progressbar.progress
progressbar.finish
selector = WalkerMethod.new(items, weights)

negative_count = 10

while gets do 
  json = JSON.parse($_)
  user = json["user"]
  items = Set.new(json["items"])
  non_items = Set.new
  
  while non_items.size < negative_count do
    item = selector.random  
    non_items << item unless items.include?(item)
  end

  items.each do |item|
    puts "1 |user #{user} |item #{item}"
  end
  non_items.each do |item|
    puts "-1 |user #{user} |item #{item}"
  end
end

