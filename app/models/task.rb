class Task < ApplicationRecord
  require 'nokogiri'

  belongs_to :user

  HEADER_TAGS = (1..6).map { |num| "h#{num}" }
  
  validates :description, :website, presence: true
  
  before_create :web_header_creating
  after_save :update_web_header

 

  private
    def web_header_creating
      doc = Nokogiri::HTML::DocumentFragment.parse(self.website)
      self.header = doc.css(*HEADER_TAGS).first.text
    end

    def update_web_header
      if attribute_present?("website")
        doc = Nokogiri::HTML::DocumentFragment.parse(self.website)
        self.update_attribute(:header, doc.css(*HEADER_TAGS).first.text)
      end
    end
end
