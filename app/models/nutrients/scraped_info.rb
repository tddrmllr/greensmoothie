module Nutrients
  class ScrapedInfo
    attr_accessor :html

    def initialize(html)
      @html = html
    end

    def amount(nutrient)
      cells(nutrient)[amount_index].text
    end

    def has_nutrient?(nutrient)
      !row(nutrient).blank?
    end

    def serving_size
      "#{serving_amount} #{serving_unit}"
    end

    def unit(nutrient)
      cells(nutrient)[unit_index].text
    end

    def usda_name
      html.css('#view-name').text
    end

    private

    def amount_index
      headers.index(input.parent)
    end

    def cells(nutrient)
      row(nutrient).children.select {|x| x.name == 'td'}
    end

    def headers
      html.css('div.nutlist table thead th')
    end

    def input
      html.css('div.nutlist table thead th input:not(#Qv)').first
    end

    def row(nutrient)
      html.css("div.nutlist table tbody tr.odd td:contains('#{nutrient.usda_name}')").first.parent
    end

    def serving_amount
      input.attr('value')
    end

    def serving_unit
      input.next.next.next.text
    end

    def unit_index
      headers.index(html.at_css("div.nutlist table thead th:contains('Unit')"))
    end
  end
end
