module ApplicationHelper

module WillPaginate::I18nViewHelpers
def will_paginate(collection, options = {})
super(collection, options.merge(:previous_label => I18n.t('will_paginate.previous'), :next_label => I18n.t('will_paginate.next')))
end
end

ActionView::Base.send :include, WillPaginate::I18nViewHelpers

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
