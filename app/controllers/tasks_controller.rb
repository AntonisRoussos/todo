class TasksController < ApplicationController

  # class << self; attr_accessor :tabpicked end  
 
  # respond_to :html, :xml, :json
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  rescue_from ActiveRecord::RecordNotFound, :with => :deny_access

  protect_from_forgery

  include ApplicationHelper 
  
  def check_date_due
    fmt=I18n.t('date.formats.default')
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

    @day = get_day_name
    @task = Task.new(params[:task])
    @task.ttype = session[:tabpicked]
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
#      format.js {render 'show', :content_type => 'text/html'}
#      format.js {render :template => '/tasks/show', :format=>:js}
#      rescue 
#      .error($!.to_s)
    end
    end

  end

  def show
     
     if params[:id] == 'F' then tasktype = 'F' end
     if params[:id] == 'P' then tasktype = 'P' end
     if params[:id] == 'W' then tasktype = 'W' end
     if params[:id] == 'S' then tasktype = 'S' end
     if params[:id] == 'A' then tasktype = 'A' end
     session[:tabpicked] =  tasktype 
     if !['F', 'P', 'W', 'S'].include? tasktype
	then
	     @tasks = Task.where(:user_id => current_user).paginate(:page => params[:page], :per_page => 10, :order =>'due DESC')
      	else
             @tasks = Task.where(:user_id => current_user, :ttype => tasktype).paginate(:page => params[:page], :per_page => 10, :order =>'due DESC')
      end
     @day = get_day_name
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
      format.js  
      format.html {redirect_to '/tasks/show'}
    end
  end


end
