class Task < ApplicationRecord
  belongs_to :user
  validates :description, :website, presence: true
  
  after_save :web_header

  private
    def web_header
    end
end
