require 'optparse'
require './lib/rankings_counter.rb'

options = Hash.new { |h, k| h[k] = [] }
OptionParser.new do |opt|
  opt.on('--file FILE') { |file| options[:file] = file }
  opt.on('--year YEAR') { |year| options[:year] = year }
  opt.on('--team YEAR') { |team| options[:team] = team }
end.parse!

if options[:file].empty?
  puts 'Please specify file with stats: ruby batting_average.rb --file stats.csv'
else
  RankingsCounter.new(options[:file], year: options[:year], team: options[:team]).call
end




