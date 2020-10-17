require 'open-uri'
require 'pry'

class Scraper
  index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/"

  def self.scrape_index_page(index_url)
    html = open(index_url)
    html_parsed_to_elements = Nokogiri::HTML(html)
    student_elements = html_parsed_to_elements

    students = []
    student_elements.css('div.student-card').each do |student|
      name = student_elements.css("a div.card-text-container h4.student-name").text
      location = student_elements.css("a div.card-text-container p.student-location").text
      profile_url = student_elements.css("a").attr("href").value

      students << student = {:name => name, :location => location, :profile_url => profile_url}
      binding.pry
    end
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

