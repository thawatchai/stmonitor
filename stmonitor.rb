#! /Users/piyawat/.rvm/rubies/ruby-2.0.0-p247/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'libnotify' if RUBY_PLATFORM =~ /linux/


uri = {
  pttep: "http://www.settrade.com/C04_01_stock_quote_p1.jsp?txtSymbol=PTTEP",
  banpu: "http://www.settrade.com/C04_01_stock_quote_p1.jsp?txtSymbol=BANPU"
}


price = {}
uri.each do |k, v|
  doc = Nokogiri::HTML(open(v))
  doc.xpath('//*[@id="cnt"]/div[1]/div[1]/div[5]/div[1]/div[1]/div[1]/div/div/div/div/div[4]').each do |node|
    price[k] = node.content
  end
end

msg = "PTTEP: #{ price[:pttep] }\rBANPU: #{ price[:banpu] }"

if RUBY_PLATFORM =~ /linux/
  Libnotify.show :summary => '', :body => msg
else
  system "growlnotify -n SET -m '#{ msg }'"
end
