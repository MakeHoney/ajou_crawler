require 'http'
require 'open-uri'
require 'nokogiri'

def fix_irregular_html(html)
  regexp = /<([^<>]*)(<|$)/

  #we need to do this multiple time as regex are overlapping
  while (fixed_html = html.gsub(regexp, "&lt;\\1\\2")) && fixed_html != html
    html = fixed_html
  end

  fixed_html
end
integratedUrl = ""


url = 'http://www.ajou.ac.kr/kr/life/food.jsp?date=2018-03-30'
open(url) {|f|
  f.each_line {|line|
  	si = line.gsub!('<', 'sibal')
  	p si
  	# p fix_irregular_html(line)
  	# integratedUrl += line
  }
  # p f.base_uri         # <URI::HTTP:0x40e6ef2 URL:http://www.ruby-lang.org/en/>
  # p f.content_type     # "text/html"
  # p f.charset          # "iso-8859-1"
  # p f.content_encoding # []
  # p f.last_modified    # Thu Dec 05 02:45:02 UTC 2002
}
# url = HTTP.get('http://www.ajou.ac.kr/kr/life/food.jsp?date=2018-03-30').to_s
# abc = fix_irregular_html(url)
# puts abc
# # page = Nokogiri::HTML(url).to_xhtml(indent:3)

# page = Nokogiri::HTML(abc)

# puts page
# page.gsub!('&#13;', "")
# page2 = page.gsub(/\s+/, "")
# page3 = Nokogiri::HTML(page)
# page3.css('table.ajou_table').each do |li|
# 	puts li.text
# 	puts '************************'
# end
# puts page3.css('table.ajou_table td')[10].text


# page.css('table.ajou_table li').each do |li|
# 	puts li.text
# end


# page3.css('table.ajou_table li').each do |li|
# 	puts li.text
# end