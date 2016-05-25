# -*- coding: utf-8 -*-

require "open-uri"
require "nokogiri"

module Jigokuno
  URL               = "http://jigokuno.com/"
  NEXT_CSS_SELECTOR = ".archiveNav a[rel='next']"

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
      @html.xpath("//article").each { |article|
        h1 = article.at(".//h1")
        category_anchor = article.at(".//div[@class='article-category']/a")

        permalink_of_category = category_anchor.attribute("href").value
        permalink_of_article = h1.at("./a/@href").value
        id_str, title = h1.text.scan(/惚れさせ([０-９0-9]+).*「(.+)」/).first

        scraped = {
          id:        id_str.tr("０-９", "0-9").to_i,
          title:     title,
          body:      article.at(".//img[@class='pict']/@alt").value,
          image:     article.at(".//img[@class='pict']/@src").value,
          character: category_anchor.text,
          cid:       extract_cid(permalink_of_category),
          eid:       extract_eid(permalink_of_article)
        }

        yield scraped
      }
    end

    private
    def extract_eid(url)
      if matched = url.match(/eid_(\d+)/)
        matched[1].to_i
      else
        raise "Can't extract eid from #{url}"
      end
    end

    def extract_cid(url)
      if matched = url.match(/cid_(\d+)/)
        matched[1].to_i
      else
        raise "Can't extract cid from #{url}"
      end
    end
  end
end
