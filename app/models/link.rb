class Link < ActiveRecord::Base
  before_save { self.original = original.downcase }

  validates :original, presence: true,
                       uniqueness: true

  validates :shorten, presence: true,
                      uniqueness: true,
                      length: { minimum: 4 }
end
