require 'active_record'

class Survey < ActiveRecord::Base
  has_many :questions
  belongs_to :user

  validates_presence_of :title
end
