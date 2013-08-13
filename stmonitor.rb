#! /Users/piyawat/.rvm/rubies/ruby-2.0.0-p247/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

uri = "http://www.settrade.com/C04_01_stock_quote_p1.jsp?txtSymbol=PTTEP"

doc = Nokogiri::HTML(open(uri))

price = 0
doc.xpath('//*[@id="cnt"]/div[1]/div[1]/div[5]/div[1]/div[1]/div[1]/div/div/div/div/div[4]').each do |node|
  price = node.content
end

system "growlnotify -n PTTEP -m #{ price }"
