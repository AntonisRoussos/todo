class SessionsController < ApplicationController

  protect_from_forgery
  include SessionsHelper

  def new
    @title = "Sign in"
  end

  def create
	user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    	
	if user.nil?
     	 flash.now[:error] = "Invalid email/password combination."
     	 @title = "Sign in"
     	 render 'new'
    	else
	  if user.status == false
	    flash.now[:error] = "Please check your mail to activate your account."
            @title = "Sign in"
     	    render 'new'
	  else
            sign_in user
     	    redirect_to('/tasks/show')
            # redirect_back_or user
    	  end
	end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
