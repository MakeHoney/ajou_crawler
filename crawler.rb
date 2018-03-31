require 'open-uri'
require 'nokogiri'
url = 'http://www.ajou.ac.kr/kr/life/food.jsp'
page = Nokogiri::HTML(open(url)).to_xhtml(indent:3)

page.gsub!('&#13;', "")
# page2 = page.gsub(/\s+/, "")
page3 = Nokogiri::HTML(page)

puts page3.css('ul.tri_list02 li').text