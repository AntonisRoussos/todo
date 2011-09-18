class Place < ActiveRecord::Base

  has_many  :tasks, :dependent => :destroy
  belongs_to :user, :foreign_key => 'user'

end
