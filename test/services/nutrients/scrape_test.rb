require 'test_helper'

module Nutrients
  class ScrapeTest < UnitTest
    test 'run returns ScrapedInfo if info found' do
      scraper = Scrape.new(url: nutrition_info_html)
      assert_kind_of ScrapedInfo, scraper.run
    end

    test 'run returns MissingInfo if no info found' do
      URI.stub :encode, nutrition_info_html do
        scraper = Scrape.new(name: 'Kale')
        assert_kind_of MissingInfo, scraper.run
      end
    end

    test 'parse_search_results should return a valid link if a result is found' do
      scraper = Scrape.new(url: nutrition_info_html, name: 'Kale')
      search_results = Nokogiri::HTML(open(kale_search_html))
      nutrition_link = scraper.parse_search_results(search_results)
      assert_equal kale_url, nutrition_link.attr('href')
    end

    private

    def kale_search_html
      Rails.root + 'test/fixtures/files/kale_search.html'
    end

    def kale_url
      "http://ndb.nal.usda.gov/ndb/foods/show/2983?fgcd=&manu=&lfacet=&format=&count=&max=200&offset=&sort=&qlookup=kale"
    end
  end
end
