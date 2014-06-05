class Link < ActiveRecord::Base
  before_save { self.original = original.downcase }
  before_create :parse_title
  before_create :validate_shorten

  validates :original, presence: true,
                       uniqueness: true

  private
    def crawl_original_by_binary
      # Dependency : original

      require 'open-uri'
      require 'nokogiri'

      Nokogiri::HTML(open(self.original)).to_s.unpack("B*")
    end

    def crawl_original
      # Dependency : original

      require 'open-uri'
      require 'nokogiri'

      Nokogiri::HTML(open(self.original))
    end

    def convert_binary_to_utf8(binary)
      binary.encode('utf-8', 'binary', :invalid => :replace, :undef => :replace)
    end

    def convert_encoding_to_UTF8(string)
      require 'iconv'

      ms949_to_utf8 = Iconv.new("UTF-8", "EUC-KR")

      return ms949_to_utf8.iconv(string) if string.encoding == "MS949"
      return string
    end

    def parse_title
      if !self.title
        # Dependency : crawl_original
        # source = convert_binary_to_utf8(crawl_original_by_binary)
        source  = convert_encoding_to_UTF8(crawl_original)
        self.title = source.css('title').inner_html.to_s
      end
    end

    def validate_shorten
      self.shorten = create_new_shorten if self.shorten.blank?
    end

    def create_new_shorten
      SecureRandom.urlsafe_base64.first(6)
    end
end
