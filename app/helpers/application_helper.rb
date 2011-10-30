module ApplicationHelper

# require 'date'
def get_day_name
  return I18n.t 'date.abbr_day_names'
end
module WillPaginate::I18nViewHelpers
def will_paginate(collection, options = {})
super(collection, options.merge(:previous_label => I18n.t('will_paginate.previous'), :next_label => I18n.t('will_paginate.next')))
end
end

ActionView::Base.send :include, WillPaginate::I18nViewHelpers

def date_is_valid?(format, date)
  begin

  	civildate = case format
  	when "%d/%m/%Y" then Date.civil(date[6,4].to_i, date[3,2].to_i, date[0,2].to_i)
   	when "%m/%d/%Y" then Date.civil(date[6,4].to_i, date[0,2].to_i, date[3,2].to_i)
   	when "%Y/%m/%d" then Date.civil(date[0,4].to_i, date[3,2].to_i, date[8,2].to_i)
   	else Date.civil(0000,00,00)
  	end
  rescue ArgumentError
    	false
  end

#      	return Date::valid_date?(civildate)
end
	   


def language_select(f)
f.collection_select(:selected_language, language_lookup,:label,:value,{:prompt=>"Select language"})
#f.collection_select(:selected_language, I18n.available_locales,:label,:value,{:prompt=>"Select language"})
end


private

def language_lookup
#create an emptycollection to hold the LabelValue Objects
languages = Array.new()
#I18n.available_locales.each do |lg|
Todo::Application.config.application_locales.each do |lg| 
l = LabelValue.new
#logger.debug ("===========================#{lg}")
#logger.debug ("#{lg}")
#puts "Hello, logs!"
l.value = I18n.name_for_locale(lg[15,2])
l.label = lg[15,2]
languages.push(l)
end
return languages
end

end
