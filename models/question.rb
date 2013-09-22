require 'active_record'

class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses

  validates_presence_of :question
end
