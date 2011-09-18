class HomeController < ApplicationController

 include SessionsHelper

def index
  if signed_in?
	  redirect_to('/tasks/show')
  end
	#logger.debug("#{Todo::Application.config.application_locales}")
end

end
