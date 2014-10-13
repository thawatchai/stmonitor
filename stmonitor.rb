#! /Users/piyawat/.rvm/rubies/ruby-2.0.0-p247/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'libnotify' if RUBY_PLATFORM =~ /linux/

stocks = ['PTTEP', 'PTTGC', 'KTB']
uri = "http://www.settrade.com/C04_01_stock_quote_p1.jsp?txtSymbol="

msg = ''
stocks.each do |s|
  doc = Nokogiri::HTML(open(uri + s))
  doc.xpath('//*[@id="cnt"]/div[1]/div[1]/div[5]/div[1]/div[1]/div[1]/div/div/div/div/div[4]').each do |node|
    msg += "#{s}: #{node.content}\n"
    # price[k] = node.content
  end
end

if RUBY_PLATFORM =~ /linux/
  Libnotify.show :body => msg
else
  system "growlnotify -n SET -t SET -m '#{ msg }'"
  # system "terminal-notifier -title 'SET' -message '#{ msg }'"
  # system "growly -t 'SET'  'echo \"#{ msg }\"'"
end
