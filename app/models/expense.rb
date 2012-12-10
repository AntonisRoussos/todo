class Expense < ActiveRecord::Base
#	validates_uniqueness_of :mobileid
	validates :mobileid,
            :uniqueness => true,
            :allow_nil => true
  	belongs_to :user
#	has_one  :category, :foreign_key => 'code', :dependent => :destroy
#	has_one  :subcategory, :foreign_key => 'Category_ code', :dependent => :destroy
	belongs_to :category
	belongs_to :subcategory
end
