require 'nokogiri'
require 'open-uri'

sections = [
  "ArtandDesign",
  "FashionandStyle",
  "Movies",
  "Music",
  "Theater",
  "Books",
  "Dance",
  "Television",
  "Sports",
  "Tennis"
]

titles = []
today = Time.now.to_s
filename = "#{today}.txt"

sections.each do |section|
  url = "http://rss.nytimes.com/services/xml/rss/nyt/#{section}.xml"
  page = Nokogiri::HTML( open(url) )
  nodes = page.xpath("//item//title")
  titles << "--------------------"
  titles << section
  titles << "--------------------"
  nodes.each { |n| titles << n.text }
end

File.open(filename, 'w') do |file|
  titles.each_with_index do |title, index|
    file.write title
    file.write "\n"
  end
end

p 'Done!'
