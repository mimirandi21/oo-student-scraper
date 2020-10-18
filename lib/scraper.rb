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
      name = student.css("a div.card-text-container h4.student-name").text
      location = student.css("a div.card-text-container p.student-location").text
      profile_url = student.css("a").attr("href").value

      students << student = {:name => name, :location => location, :profile_url => profile_url}
      
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    
    stats = Nokogiri::HTML(open(profile_url))
    
    student = {}
    links = stats.css(".social-icon-container").css("a").map {|link| link.attr("href")}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
      student[:profile_quote] = stats.css("div.profile-quote").text
      student[:bio] = stats.css("div.description-holder p").text
      
    
    student
  #   :twitter=>"http://twitter.com/flatironschool",
  # :linkedin=>"https://www.linkedin.com/in/flatironschool",
  # :github=>"https://github.com/learn-co",
  # :blog=>"http://flatironschool.com",
  # :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  # :bio=> "I'm a school"
  end

end

