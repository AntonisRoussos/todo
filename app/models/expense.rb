class Expense < ActiveRecord::Base
	validates_uniqueness_of :webid
end
