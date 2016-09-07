#!/usr/bin/env ruby
require 'HTTParty'
require 'nokogiri'
# require 'pry'
# require 'csv'
require "open-uri"

# open('http://www.funda.nl/koop/eindhoven/huis-49975514-frankrijkstraat-43/', "Accept-Encoding" => "plain") do |f| 
# 	Nokogiri::HTML(f.read)
# end

def get_page(url)
	open(url, "Accept-Encoding" => "plain") do |f| 
		Nokogiri::HTML(f.read)
	end
end

class String
	def squish
		self.strip.gsub(/\s+/, " ")
	end
end

def parse_funda_page(url)

	parse_page = get_page(url)

	@funda = []

	parse_page.css('.object-kenmerken-body').search('dt').each do |node|
		case node.text
		when 'Vraagprijs'
    	# remove whitespaces and all non digits
    	val = node.next_element.text.squish.gsub!(/\D/, "")
    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Soort woonhuis'
    	val = node.next_element.text.squish
    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Bouwjaar'
    	val = node.next_element.text.squish
    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Soort bouw'
    	val = node.next_element.text.squish
    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Woonoppervlakte'
    	val = node.next_element.text.squish.gsub!(/\D/, "")

    	# remove whitespaces and all non digits
    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Perceeloppervlakte'
    	val = node.next_element.text.squish.gsub!(/\D/, "")

    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Inhoud'
    	val = node.next_element.text.squish.gsub!(/\D/, "")

    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Aantal kamers'
    	val = node.next_element.text.squish.gsub!(/\D/, "")

    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Aantal woonlagen'
    	val = node.next_element.text.squish.gsub!(/\D/, "")

    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Energielabel'
    	val = node.next_element.text.squish[0..1].squish

    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Ligging'
    	val = node.next_element.text.squish

    	puts "#{node.text}: #{val}"
    	@funda << val
    when 'Achtertuin'
    	val = node.next_element.text.squish.gsub!(/m.+\)/, "").squish

    	puts "#{node.text}: #{val}"
    	@funda << val    	
    when 'Soort garage'
    	val = node.next_element.text.squish

    	puts "#{node.text}: #{val}"
    	@funda << val
    end
  end

  File.open("funda.txt", "a") do |file| 
  	file.write @funda.join(";") 
  	file.write "\n"
  end
end

parse_funda_page('http://www.funda.nl/koop/eindhoven/huis-49975514-frankrijkstraat-43/')

# p get_page('http://www.funda.nl/koop/eindhoven/huis-49975514-frankrijkstraat-43/')

# Deamonize this script
# Process.daemon

# Check geldvoorelkaar every x mins for new projects

# while true
# 	projects ||= get_latest_projects
# 	sleep 60 # seconds
# 	new_projects = get_latest_projects
# 	latest_project = new_projects - projects

# 	if !latest_project.empty? && new_project_on_page?
# 		message = "2.0 | New project found: #{latest_project.first}!"
# 		HTTParty.post("https://api.pushover.net/1/messages.json", query: { :token => 'aDsmZKda6yAdBrNdCV7XzvYsP7aqG4', :user => 'uzGbW2F9bi3gniYcMAJ9yNN7Ayr583', :message => message } )
# 		projects = new_projects
# 	end
# end


# def get_latest_projects
# 	parse_page = get_page
# 	company_names = []

# 	parse_page.css('.LeningTekstKort span').map do |a| 
# 		company_name = a.text
# 		company_names.push(company_name)
# 	end
# 	company_names
# end