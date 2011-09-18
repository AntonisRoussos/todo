class Notification < ActiveRecord::Base

  attr_accessible :status      

  validates_inclusion_of :status, :in => ["N", "A", "D"], :allow_nil =>false
  belongs_to :user
  belongs_to :user, :foreign_key => 'assigner'

end
