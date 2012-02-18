class TasksController < ApplicationController

  # class << self; attr_accessor :tabpicked end  
 
  # respond_to :html, :xml, :json
  before_filter :authenticate, :only => [:edit, :update]
#  before_filter :correct_user, :only => [:edit, :update]
  rescue_from ActiveRecord::RecordNotFound, :with => :deny_access

  protect_from_forgery

  include ApplicationHelper 
  
  def check_date_due
    fmt=I18n.t('date.formats.default')
#     logger.debug "--format-------------------------------------------"
#     logger.debug "#{fmt}"
#     logger.debug "--date-------------------------------------------"
#     logger.debug "#{params[:task]}"
    respond_to do |format|
          if date_is_valid?(fmt, params[:task][:due]) 
     		a = format.json { render :json => true }
          else
     		a = format.json { render :json => false }
          end
 	end
  end

  def create
#     logger.debug "#{session[:tabpicked]}"
#     logger.debug "--create-------------------------------------------"

    @task = Task.new(params[:task])
    @task.ttype = session[:tabpicked]
    @day = get_day_name
    fmt=I18n.t('date.formats.default')
    tdate = DateTime.strptime(str=params[:task][:due],fmt)
#    logger.debug "#{tdate}"
#     logger.debug "--datetime-------------------------------------------"
    @task.due = tdate
    @task.user_id = current_user.id
    if @task.ttype == 'A' then @task.ttype = 'P'end
#    @task = current_user.tasks.create(params[:task])
#    if @task.save!
#     respond_with do |format|
#      format.html do
#        if request.xhr?
#          render :partial => "tasks/shownewtask", :locals => { :task => @task }, :layout => false, :status => :created
#        else
#          redirect_to @comment
#        end
#      end
#    end
    respond_to do |format|
    if @task.save
      format.js 
      format.html {redirect_to '/tasks/show'}
#      format.js { render :js => @task, :status => :created, :location => @task, :layout => !request.xhr? }
#      format.js {render 'create', :content_type => 'text/html'}
#      format.js {render :template => '/tasks/show', :format=>:js}
#      rescue 
#      .error($!.to_s)
    end
    end

  end

  def edit
#    @task = Task.find(params[:id])
#    @title = t(:Edit_user_settings)
#    render :layout => false
#    respond_to do |format|
#       format.html {render :action => "edit", :format => :html , :layout => false}
#       format.js {render :action => "edit", :format => :html , :layout => false}
#       format.html {render :action => "edit", :format => :html}
#       format.js {render :action => "edit", :format => :js}
#    end
  end


  def update
    @task = Task.find(params[:task][:id])
#    respond_to do |format|
    fmt=I18n.t('date.formats.default')
    tdate = DateTime.strptime(str=params[:task][:due],fmt)
    @task.due = tdate
    logger.debug "--@task.due-------------------------------------------"
    logger.debug "#{@task.due}"
    logger.debug "--params[:date]-before------------------------------------------"
    logger.debug "#{params[:task][:due]}"
    params[:task][:due] = @task.due
     logger.debug "--params[:date]-after------------------------------------------"
    logger.debug "#{params[:task][:due]}"
	if @task.update_attributes(params[:task])
#	        flash[:success] = t(:Settings_updated)
#		format.js  {redirect_to :action => "show", :format => :js, :id => session[:tabpicked]} 
#		format.html {redirect_to '/tasks/show'}
#		format.html {redirect_to :back}
#		format.html {redirect_to :action => "show", :format => :js, :id => session[:tabpicked]} 

	else
#		format.js  {redirect_to :action => "show", :format => :js, :id => session[:tabpicked]} 
#		format.html {redirect_to :back}
#		format.html {redirect_to :action => "show", :format => :js, :id => session[:tabpicked]} 
#		format.html {redirect_to '/tasks/show'}
#	        flash[:success] = t(:Unexpected_error_during_user_settings_update)
#      		@title = t(:Edit_user_settings)
#   		render 'edit'
    	end
#    end
  end

  def show1
  end

  def show
#     logger.debug "----------------------------------------------"
#     logger.debug "#{params[:id]}"
     
     if params[:id] == 'F' then tasktype = 'F' end
     if params[:id] == 'P' then tasktype = 'P' end
     if params[:id] == 'W' then tasktype = 'W' end
     if params[:id] == 'S' then tasktype = 'S' end
     if params[:id] == 'A' then tasktype = 'A' end
     if !['F', 'P', 'W', 'S'].include? tasktype
	then
	     @tasks = Task.where(:user_id => current_user).paginate(:page => params[:page], :per_page => 10, :order =>'due DESC')
      	else
             @tasks = Task.where(:user_id => current_user, :ttype => tasktype).paginate(:page => params[:page], :per_page => 10, :order =>'due DESC')
      end
#    logger.debug "----------------------------------------------"
#     logger.debug "#{@tasks}"
     @day = get_day_name
     session[:tabpicked] =  tasktype 
     respond_to do |format|
          format.html  
          format.xml  { render :xml => @tasks }
          format.js  {if @tasks.count > 0 then render 'show', :content_type => 'text/html' else render 'notasks', :content_type => 'text/html'  end}
#          format.js  {if @tasks.count > 0 then render :partial => 'show', :content_type => 'text/html' else render 'notasks', :content_type => 'text/html'  end}

#          format.js  {render(:update) {|page| page.replace_html 'show', :partial => 'show'} }
     end

 end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
#    		format.js  {redirect_to :action => "show", :format => :js, :id => session[:tabpicked]} 
    		format.js
		format.html {redirect_to :back} 
    end
  end


  def retrieve_day
    logger.debug "--date-------------------------------------------"
    logger.debug "#{params[:date]}"
    @day = get_day_name
#   received_date = Time.parse(params[:date], "%Y-%m-%d %H:%M:%S")
#    received_date = Time.parse(params[:date], "%d%m%Y %H:%M:%S")
    received_date = Date.strptime(params[:date], '%d/%m/%Y') 
    logger.debug "--received_date-------------------------------------------"
    logger.debug "#{received_date}"
    @date_response = @day[received_date.wday] + " " + received_date.strftime("%d") + "/" + received_date.strftime("%m") + "/" + received_date.strftime("%y")	
    logger.debug "--@date_response-------------------------------------------"
    logger.debug "#{@date_response}"
    respond_to do |format|
#      format.xml { render :xml => @date_response}
	format.xml
    end
  end

end
