class Expense < ActiveRecord::Base
#	validates_uniqueness_of :mobileid
	validates :mobileid,
            :uniqueness => true,
            :allow_nil => true
  	belongs_to :user
end
