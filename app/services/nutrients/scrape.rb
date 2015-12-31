module Nutrients
  class Scrape
    attr_accessor :name, :url

    def self.run(args)
      new(args).run
    end

    def run
      return MissingInfo.new if url.blank?
      ScrapedInfo.new(html_from_url)
    end

    def parse_search_results(search_results)
      search_results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name.capitalize}, raw')") ||
      search_results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name.capitalize.pluralize}, raw')") ||
      search_results.at_css(".wbox table tbody tr td:nth-child(2) a:contains('#{name}')")
    end

    private

    def html_from_url
      Nokogiri::HTML(open(url))
    end

    def initialize(args = {})
      @name = args[:name]
      @url = args[:url] || search_nutrients
    end

    def search_nutrients
      search_results = Nokogiri::HTML(open(search_url))
      nutrition_link = parse_search_results(search_results)
      return if nutrition_link.blank?
      "http://ndb.nal.usda.gov/#{nutrition_link.attr('href')}"
    end

    def search_url
      URI.encode("http://ndb.nal.usda.gov/ndb/foods?&qlookup=#{name}&max=200")
    end
  end
end
