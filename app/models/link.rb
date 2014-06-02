class Link < ActiveRecord::Base
  before_save { self.original = original.downcase }
  before_create :parse_title
  before_create :validate_shorten

  validates :original, presence: true,
                       uniqueness: true

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

    def validate_shorten
      self.shorten = create_new_shorten if self.shorten.blank?
    end

    def create_new_shorten
      SecureRandom.urlsafe_base64.first(6)
    end
end
