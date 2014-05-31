class Link < ActiveRecord::Base
  validates :original, presence: true,
                       uniqueness: true

  validates :shorten, presence: true,
                      uniqueness: true,
                      length: { minimum: 4 }

  validates :public, presence: true
end
