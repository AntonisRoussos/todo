class ApplicationController < ActionController::Base
include SessionsHelper

before_filter :set_locale
def set_locale
  # if params[:locale] is nil then I18n.default_locale will be used
 # I18n.locale = params[:locale]
   if !current_user.nil?
	I18n.locale = current_user.selected_language
   else
	I18n.locale = request.compatible_language_from I18n.available_locales
   end
end

before_filter :export_i18n_messages

  private
  def export_i18n_messages
    SimplesIdeias::I18n.export! if Rails.env.development?
#    SimplesIdeias::I18n.export!
  end


  protect_from_forgery

  private
        
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, 	password|
      user_name == 'admin' && password == 'password'
    end
  end

end
