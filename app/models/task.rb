class Task < ActiveRecord::Base
  require 'validations'

  attr_accessible :ttype, :subtype, :priority, :due, :notification, :repititive, :finish_on, :status, :status_date, :assigner, :email_notification_to_assignee, :sms_notification_to_assignee, :email_notification_to_assigner, :sms_notification_to_assigner, :accessible_by, :budget, :place_id, :description, :long_description

#  validates_inclusion_of :ttype, :in => ["P", "F", "W", "V"], :allow_nil =>false
  validates_inclusion_of :priority, :in => ["L", "M", "H"], :allow_nil =>false
#  validates_inclusion_of :status, :in => ["O", "C", "D", "P"], :allow_nil =>false
#  validates_format_of :budget, :with => /\d{0,7}\.\d{2}/
#  validates_positive_or_zero :budget

  belongs_to :user
  belongs_to :user, :foreign_key => 'assigner'
  belongs_to :place

end
