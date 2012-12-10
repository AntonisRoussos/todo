class Category < ActiveRecord::Base
  has_many  :expenses, :dependent => :destroy
  belongs_to :user
  belongs_to :subcategory
end
