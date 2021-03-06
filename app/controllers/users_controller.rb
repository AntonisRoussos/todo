# require 'json'
class UsersController < ApplicationController
    
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  rescue_from ActiveRecord::RecordNotFound, :with => :deny_access

  protect_from_forgery
  include SessionsHelper
  include UsersHelper 
  #  GET /users
  # GET /users.xml
  def index
    @users = User.all
    @users = User.paginate :page => params[:page], :per_page => 	3
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    @user.selected_language = I18n.locale

    respond_to do |format|
      if @user.save
	sendactivationmail(@user.email, @user.name, @user.id)
  #	sign_in @user
        format.html {
  #      flash[:success] = t(:"Please check your mail to activate your account.")
        flash[:success] = t(:check_mail)
	redirect_to @user}
        format.xml  { render :xml => @user, :status => :created, :location => @user }   
	format.json  { render :xml => @user, :status => :created, :location => @user }
      else
	@title = "Sign up"
        format.html { render :action => "new" }
  #	logger.debug ("-----------------------------")
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
	format.json { render :json => @user.errors, :status => :unprocessable_entity }
	
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = t(:Edit_user_settings)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def update
        @user = User.find(params[:id])
	if @user.update_attributes(params[:user])
	        flash[:success] = t(:Settings_updated)
      		redirect_to @user
    	else
	        flash[:success] = t(:Unexpected_error_during_user_settings_update)
      		@title = t(:Edit_user_settings)
   		render 'edit'
    	end
  end


  def activateuser 
    @user = User.find(params[:id])
    if @user.update_attribute(:status, true)
      flash[:success] = t(:user_activated)
    else
      flash[:success] = t(:Unexpected_error_during_user_activation)
    end
    redirect_to @user
  end

  def check_email
        @user = User.find_by_email(params[:user][:email])
	respond_to do |format|
     	  if (!@user.nil? and !params[:id].nil?)
	      if @user.id == Integer(params[:id])
     		a = format.json { render :json => true }
	      else
     		a = format.json { render :json => false }
              end
   	  else	   
     	      a = format.json { render :json => !@user }
	   end
  	end
  end

  def check_name
        @user = User.find_by_name(params[:user][:name])
	respond_to do |format|
           if  (!@user.nil? and !params[:id].nil?)
	      if @user.id == Integer(params[:id])
     		a = format.json { render :json => true }
	      else
     		a = format.json { render :json => false }
              end
   	   else	   
     	      a = format.json { render :json => !@user }
	   end
  	end
  end


  def MailPasswordRequest
  end
  
  def MailPassword
    @user = User.find_by_email(params[:email])
    respond_to do |format|
      if (@user and @user.status == true)
	encrypted_hash = updatepasswordfields(@user)
	sendpasswordmail(@user.email, @user.name, encrypted_hash)
        format.html { 
        flash[:success] = t(:Please_check_your_mail_to_reset_your_password)
        format.xml  { render :xml => @user, :status => :created, :location => @user }   
	format.json  { render :xml => @user, :status => :created, :location => @user }
	}
      else
        format.html { 
        flash[:success] = t(:User_mail_does_not_exist_or_the_user_is_not_activated)
	}
      end
      redirect_to root_url
   end
  end

  def ResetPasswordRequest
    encrypted_hash = params[:encryptedhash]
    cryptopass = encrypted_hash[2,1] + encrypted_hash[13,1] + encrypted_hash[21,1] + encrypted_hash[22,1]
    @user = User.find_by_cryptopass(cryptopass)
    if @user
       diff = (Time.now.utc - @user.time_forgot_password)/60
       logger.debug("#{diff}")
       if (diff < 30 and diff > 0)
          acceptable_request = true
       else
          acceptable_request = false
       end
    end       
    if !@user or !acceptable_request 
      sign_out
      flash[:success] = t(:Your_password_request_has_expired!)
      redirect_to root_url
    end
  end

  def ResetPassword
    @user = User.find(params[:user][:id])
    @user.cryptopass = nil
    @user.time_forgot_password = nil
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = t(:user_password_was_reset)
    else
      flash[:success] = t(:Unexpected_error_during_password_reset)
    end
    redirect_to @user
  end

  def ChangePasswordRequest
    @user = User.find(params[:id])
  end

  def ChangePassword
   existinguserpassword = params[:existinguserpassword] 
   @user = User.find(params[:user][:id])
    if !verified_password?(existinguserpassword)
	flash[:success] = t(:Wrong_existing_password)
        render 'ChangePasswordRequest'
    else  
      if @user.update_attributes(params[:user])
        sign_in @user
        flash[:success] = t(:Your_password_has_changed)
      else
        flash[:success] = t(:Unexpected_error_during_password_change)
      end
      redirect_to @user
    end
  end

  def DownloadMobile
#	send_file './public/downloads/Expenses.apk', :type => 'application/apk', :disposition => 'inline'
#	send_file './public/downloads/Expenses.apk', :type => 'application/apk'
	send_file './public/downloads/Expenses.apk'
  end

end


