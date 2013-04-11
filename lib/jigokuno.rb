# -*- coding: utf-8 -*-

require "open-uri"

require "rubygems"
require "nokogiri"

module Jigokuno
  URL        = "http://jigokuno.com/"
  NEXT_XPATH = "//div[@id='page_area']/div[@class='page_navi']/a[contains(text(), '>>')]"

  class Misawa
    include Enumerable

    attr_reader :current

    def initialize
      @current  = URL
      @document = Nokogiri::HTML(open(@current))
    end

    def next
      next_link = @document.at(NEXT_XPATH)

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
        h2 = entry.xpath(".//h2").text.tr("０-９", "0-9").chomp
        id, title = h2.scan(/惚れさせ(\d+).*「(.+)」/).first

        id        = id.to_i
        title     = title.to_s
        image     = entry.at(".//img[@class='pict']").attributes["src"].to_s
        character = entry.at("center/ul/li[2]/a").text
        cid       = entry.at("center/ul/li[2]/a").attributes["href"].to_s.slice(/cid=(.+)/,1).to_i
        eid       = entry.at("h2/a").attributes["href"].to_s.slice(/eid=(.+)/,1).to_i

        yield Hash[{
          :id        => id,
          :title     => title,
          :image     => image,
          :character => character,
          :cid       => cid,
          :eid       => eid
        }]
      }
    end
  end
end
