class ExpensesController < ApplicationController

  responsecode = 0

  include ApplicationHelper 
  include ExpensesHelper 
  include SessionsHelper


  def check_date_due
    fmt=I18n.t('date.formats.default')
    respond_to do |format|
          if date_is_valid?(fmt, params[:expense][:dateoccured]) 
     		a = format.json { render :json => true }
          else
     		a = format.json { render :json => false }
          end
 	end
  end



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
    @title = t(:Edit_user_settings)
#    render :layout => false
    respond_to do |format|
#       format.html {render :action => "edit", :format => :html , :layout => false}
       format.js 
#       format.html {render :action => "edit", :format => :html}
#       format.js {render :action => "edit", :format => :js}
    end

  end

  # POST /expenses
  # POST /expenses.xml
  def create1
    @expense = Expense.new(params[:expense])
    @expense.user_id = current_user.id
    operation = "A"
    if success = @expense.save
	expense=@expense
	insert_to_expenses_journal(operation, expense)   
    end
    respond_to do |format|
      if @expense.save
        format.html { redirect_to(@expense, :notice => 'Expense was successfully created.') }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create
    @expense = Expense.new(params[:expense])
    @expense.user_id = current_user.id
    @expense.ttype = "E"
    @day = get_day_name
    fmt=I18n.t('date.formats.default')
    tdate = DateTime.strptime(str=params[:expense][:dateoccured],fmt)
    @expense.dateoccured = tdate
    operation = "A"
    respond_to do |format|
      if success = @expense.save
	expense=@expense
	insert_to_expenses_journal(operation, expense)   
	format.js 
      	format.html {redirect_to '/expenses/shownew'}
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
#      format.html { redirect_to(expenses_url) }
      format.html {redirect_to :back} 
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
 
  def show1
     
     respond_to do |format|
          format.html  
          format.xml  { render :xml => @expenses }
          format.js  {
	     if params[:term]
	     then 
		render 'autocomplete'
	     else
		  if @expenses.count > 0 then render 'shownew', :content_type => 'text/html' else render 'noexpenses', :content_type => 'text/html'  end
	     end
	  }
          format.json  { render :json => @tasks }
#          format.json  { render :json => @tasks }
#          format.js  {if @tasks.count > 0 then render :partial => 'show', :content_type => 'text/html' else render 'notasks', :content_type => 'text/html'  end}

#          format.js  {render(:update) {|page| page.replace_html 'show', :partial => 'show'} }
     end

  end

  def shownew
     
     if params[:id] == 'E' then expensetype = 'E' end
     if params[:id] == 'I' then expensetype = 'I' end
     if params[:id] == 'R' then expensetype = 'R' end
     if params[:id] == 'B' then expensetype = 'B' end
     @expenses = Expense.where(:user_id => current_user).paginate(:include => [:category, :subcategory], :page => params[:page], :per_page => 10, :order =>'dateoccured DESC')
#     @categories = Category.where(:user_id => current_user)
     $subcategories = Array.new()
=begin
     i=0
	@expenseid = {}
	@expenseamount = {}
	@expensedateOccured = {}
	@expensecategory = {}
	@expensesubcategory = {}
	@expensettype = {}
     for expense in Expense.find(:all,:include => [:category]) 
     logger.debug "-------------------------------------------------------#{expense.category.elDescription}"
     logger.debug "#{expense.category.elDescription}"
     logger.debug "#{expense}"
	   i += 1	
	@expenseid [i] = expense.id
	@expenseamount [i] = expense.amount
	@expensedateOccured [i] = expense.dateOccured
	@expensecategory [i] = expense.category.elDescription
	@expensesubcategory [i] = expense.subcategory.elDescription
	@expensettype [i] = expense.ttype
     end
=end
	
     @day = get_day_name
     session[:tabpicked] =  expensetype 
     respond_to do |format|
          format.html  
          format.xml  { render :xml => @tasks }
          format.js  {
	     if params[:term]
	     then 
		render 'autocomplete'
	     else
		  if @expenses.count > 0 then render 'shownew', :content_type => 'text/html' else render 'noexpenses', :content_type => 'text/html'  end
	     end
	  }
          format.json  { render :json => @tasks }
     end

 end

 def getSubcategories
     logger.debug "----------------------------------------------"
     logger.debug "#{params[:category]}"
     @subcategories = Subcategory.where(:category_id => "#{params[:category]}") 
     logger.debug "----------------------------------------------"
     logger.debug "#{$subcategories}"
     ActiveRecord::Base.include_root_in_json = false
     respond_to do |format|
	     format.json  { render :json => @subcategories.to_json( :only => [:id, :elDescription])}
     end
 end

end

