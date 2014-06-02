class Link < ActiveRecord::Base
  before_save { self.original = original.downcase }
  before_create :parse_title

  validates :original, presence: true,
                       uniqueness: true

  validates :shorten, presence: true,
                      uniqueness: true,
                      length: { minimum: 4 }

  private
    def crawl_original
      # Dependency : original

      require 'open-uri'
      require 'nokogiri'

      Nokogiri::HTML(open(self.original))
    end

    def parse_title
      # Dependency : crawl_original

      self.title = crawl_original.css('title').inner_html.to_s
    end
end
