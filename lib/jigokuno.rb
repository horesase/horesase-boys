# -*- coding: utf-8 -*-

require "open-uri"

require "rubygems"
require "nokogiri"

module Jigokuno
  URL               = "http://jigokuno.com/"
  NEXT_CSS_SELECTOR = "#pager span.pager_next a"

  class Misawa
    include Enumerable

    attr_reader :current

    def initialize
      @current  = URL
      @document = Nokogiri::HTML(open(@current))
    end

    def next
      next_link = @document.at(NEXT_CSS_SELECTOR)

      return nil if next_link.nil?

      @current  = next_link["href"]
      @document = Nokogiri::HTML(open(@current))

      self
    end

    def each
      Scraper.new(@document).meigens { |meigen| yield meigen }

      next_page = self.next
      return if next_page.nil?

      next_page.each { |meigen| yield meigen }
    end
  end

  class Scraper
    def initialize(html)
      @html = html
    end

    def meigens
      @html.xpath("//div[@class='entry_area']").each { |entry|
        h2 = entry.at(".//h2")
        category_anchor = entry.at(".//ul[@class='state']/li[2]/a")

        permalink_of_category = category_anchor.attribute("href").value
        permalink_of_entry = h2.at("./a/@href").value
        id_str, title = h2.text.scan(/惚れさせ([０-９]+).*「(.+)」/).first

        scraped = {
          id:        id_str.tr("０-９", "0-9").to_i,
          title:     title,
          image:     entry.at(".//img[@class='pict']/@src").value,
          character: category_anchor.text,
          cid:       extract_cid(permalink_of_category),
          eid:       extract_eid(permalink_of_entry)
        }

        yield scraped
      }
    end

    private
    def extract_eid(url)
      if matched = url.match(/eid=(\d+)\z/)
        matched[1].to_i
      else
        raise "Can't extract eid from #{url}"
      end
    end

    def extract_cid(url)
      if matched = url.match(/cid=(\d+)\z/)
        matched[1].to_i
      else
        raise "Can't extract cid from #{url}"
      end
    end
  end
end
