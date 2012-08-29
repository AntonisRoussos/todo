class ExpensesController < ApplicationController

  responsecode = 0

  include ApplicationHelper 
  include ExpensesHelper 
  include SessionsHelper


  # GET /expenses
  # GET /expenses.xml
  def index
#    @expenses = Expense.all
#    @expenses = Expense.where(:user_id => current_user).paginate(:page => params[:page], :per_page => 10)
    @expenses = Expense.where(:user_id => current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    @expense = Expense.new(params[:expense])
    @expense.user_id = current_user.id
    operation = "A"
    if success = @expense.save
	expense=@expense
	insert_to_expenses_journal(operation, expense)   
    end
    respond_to do |format|
      if @expense.save
#      if @expense.save and responsecode == "success" 
        format.html { redirect_to(@expense, :notice => 'Expense was successfully created.') }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
	operation = "U"
        expense=@expense
	insert_to_expenses_journal(operation, expense)   
	format.html { redirect_to(@expense, :notice => 'Expense was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = Expense.find(params[:id])
    expense=@expense
    @expense.destroy
    operation = "D"
    insert_to_expenses_journal(operation, expense)   

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
      format.xml  { head :ok }
    end
  end

  def synchronize_with_mobile
    categoryrows = params[:categoryrows]
    subCategoryrows = params[:subCategoryrows]
    mobile_data = params[:mobiledata]
#    mobile_user =  params[:user]
#    mobile_password =  params[:password]
    user = User.authenticate(params[:user],
                            params[:password])

    respond_to do |format|
	if user.nil?
	   responsecode = 1
    	else
	  if user.status == false
	     responsecode = 2
	  else
#             sign_in user
	     responsecode = 0
    	  end
	end
     
    logger.debug "#{responsecode}"
    	if responsecode == 0
 		format.json  {render :json => get_mobile_updates(categoryrows, subCategoryrows, mobile_data,user.id).unshift(responsecode)}
    	else
 		format.json  {render :json => responsecode}
    	end
    end
  
  end

  def synchronize_with_mobile_second_step
    mobile_data_2 = params[:mobileinserteddata]
    logger.debug "#{mobile_data_2}"
    respond_to do |format|
 	format.json  {render :json => get_mobile_updates_second_step(mobile_data_2)}
    end
  end

  def authenticate_mobile_user

    mobile_user =  params[:user]
#    @user = User.find_by_email(mobile_user)
    user = User.authenticate(params[:user],
                            params[:password])

    respond_to do |format|
#    logger.debug "--------------------------------------#{user.id}"
#    logger.debug "#{user.id}"
	if user.nil?
	   responsecode = 1
    	else
	  if user.status == false
	     responsecode = 2
	  else
#             sign_in user
	     responsecode = 0
    	  end
	end

    logger.debug "#{responsecode}"
 	format.json  {render :json => responsecode}
    end

  end

  def copy_to_mobile
    user = User.authenticate(params[:user],
                            params[:password])
    respond_to do |format|
	if user.nil?
	   responsecode = 1
    	else
	  if user.status == false
	     responsecode = 2
	  else
#             sign_in user
	     responsecode = 0
    	  end
	end
     
    logger.debug "#{responsecode}"
    	if responsecode == 0
 		format.json  {render :json => get_full_updates(user.id).unshift(responsecode)}
    	else
 		format.json  {render :json => responsecode}
    	end
    end
  
 end

 def fix_user_id
#    user_id = params[:user]
    logger.debug "#{current_user.id}"
    update_user_id(current_user.id)
 end


end
