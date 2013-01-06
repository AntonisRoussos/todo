module ExpensesHelper

def insert_to_expenses_journal(operation, expense)
       	category_code = ''
	subcategory_code = ''
	category_code = Category.where(:id => expense.category).first.code
	if !expense.subcategory.nil? 
		subcategory_code = Subcategory.where(:id => expense.subcategory).first.subcategory_code
	else
	     	subcategory_code = ''
       	end

	@expense_journal = ExpenseJournal.new({:trxtype => operation, :trxdatetime => Time.now, :sn => expense.id, :amount => expense.amount, :dateoccured => expense.dateoccured, :category => category_code, :subcategory => subcategory_code, :exptype => expense.ttype, :expmethod =>expense.method, :user_id =>expense.user_id})
		@expense_journal.save

end

def get_mobile_updates(categoryrows, subCategoryrows, mobile_data, user_id)
	
  response = Array.new


#update Categories

    categorycode = ''
    categorytype = ''
    categoryenDescription = ''
    categoryelDescription = ''

  if !categoryrows.nil?
   categoryrows.each_index{|i|

    remainder = i % 4

    if remainder == 0
    	categorycode = categoryrows[i]
    end
    if remainder == 1
	categorytype = categoryrows[i]
    end
    if remainder == 2
	categoryenDescription = categoryrows[i]
    end
    if remainder == 3
	 categoryelDescription = categoryrows[i]
    	 @category = Category.find_by_user_id_and_code(user_id, categorycode)
	 if @category
		@category.update_attributes(:code =>categorycode, :ttype => categorytype, :enDescription => categoryenDescription, :elDescription => categoryelDescription, :updated_at => Time.zone.now, :user_id => user_id) 
	 else
		@category = Category.new(:code =>categorycode, :ttype => categorytype, :enDescription => categoryenDescription, :elDescription => categoryelDescription, :created_at => Time.zone.now, :updated_at => Time.zone.now, :user_id => user_id)
      		@category.save
	 end
    end
   }
  end

#update subCategories

    subCategorycode = ''
    subsubCategorycode = ''
    subCategorytype = ''
    subCategoryenDescription = ''
    subCategoryelDescription = ''
    category_id = ''	
    if !subCategoryrows.nil?
   subCategoryrows.each_index{|i|

    remainder = i % 5

    if remainder == 0
    	subCategorycode = subCategoryrows[i]
    end
    if remainder == 1
	subsubCategorycode = subCategoryrows[i]
    end
    if remainder == 2
	subCategorytype = subCategoryrows[i]
    end
    if remainder == 3
	subCategoryelDescription = subCategoryrows[i]
    end
    if remainder == 4
	subCategoryelDescription = subCategoryrows[i]
	category_id = Category.where('user_id = ? AND code = ?', user_id, subCategorycode).first.id
logger.debug "-----------------------------------------------#{category_id}"
#    	@subcategory = Subcategory.where('user_id = ? AND category_id = ? AND subcategory_code = ?', user_id, category_id, subsubCategorycode).first.id
	@subcategory = Subcategory.find_by_user_id_and_category_id_and_subcategory_code( user_id, category_id, subsubCategorycode)
	if @subcategory
		@subcategory.update_attributes(:category_id => category_id, :subcategory_code =>subsubCategorycode, :ttype => subCategorytype, :enDescription => subCategoryenDescription, :elDescription => subCategoryelDescription, :updated_at => Time.zone.now, :user_id => user_id) 
	 else
		@subcategory = Subcategory.new(:category_id =>category_id, :subcategory_code =>subsubCategorycode, :ttype => subCategorytype, :enDescription => subCategoryenDescription, :elDescription => subCategoryelDescription, :created_at => Time.zone.now, :updated_at => Time.zone.now, :user_id => user_id) 
      		@subcategory.save
	 end 
    end
   }
  end



  trxtype = ''
  trxamount = 0
  trxdateOccured = 0
  trxcategory = ''
  trxsubcategory = '' 
  trxttype = ''
  trxmethod = ''
  trxmobileid = 0
  trxdatetime = ''
   category_id = '' 
  subcategory_id = '' 

# Additions
  if !mobile_data.nil?
   mobile_data.each_index{|i|

    remainder = i % 9

    if remainder == 0
    	trxtype = mobile_data[i]
    end
    if remainder == 1
	trxdatetime = mobile_data[i]
    end
    if remainder == 2
	trxmobileid = mobile_data[i]
    end
    if remainder == 3
    	trxamount = mobile_data[i]
    end
    if remainder == 4
    	trxdateOccured = mobile_data[i]
    end
    if remainder == 5
    	trxcategory = mobile_data[i]
    end
    if remainder == 6
    	trxsubcategory = mobile_data[i]
    end
    if remainder == 7
    	trxttype = mobile_data[i]
    end
    if remainder == 8
    	trxmethod = mobile_data[i]
    end 

    if (remainder == 8 and trxtype == 'A')
#    	@expense = Expense.new(:amount => trxamount, :dateoccured => trxdateOccured, :category => trxcategory, :subcategory => trxsubcategory, :ttype => trxttype, :method =>trxmethod, :mobileid =>trxmobileid, :created_at => Time.parse(trxdatetime).getutc, :updated_at => Time.parse(trxdatetime).getutc, :sync => "S")
#logger.debug "#{trxamount}"
#	logger.debug "#{trxcategory}"
#logger.debug "#{trxsubcategory}"
#logger.debug "#{trxttype}"
#logger.debug "#{trxmethod}"
#logger.debug "#{trxmobileid}"
	category_id =  Category.where('user_id = ? AND code = ?', user_id, trxcategory).first.id
	subcategory_id = Subcategory.where('user_id = ? AND category_id = ? AND subcategory_code = ?', user_id, category_id, trxsubcategory).first.id
	logger.debug "----------------------#{category_id}"
	logger.debug "----------------------#{subcategory_id}"
	@expense = Expense.new(:amount => trxamount, :dateoccured => trxdateOccured, :category_id => category_id, :subcategory_id => subcategory_id, :ttype => trxttype, :method =>trxmethod, :mobileid =>trxmobileid, :created_at => Time.zone.parse(trxdatetime), :updated_at => Time.zone.parse(trxdatetime), :sync => "S", :user_id => user_id)
logger.debug "#{@expense.amount}"
      if @expense.save
         response.push(@expense.mobileid, @expense.id)
	logger.debug "ooooooooooooooooooook"
      else
         response.push(@expense.mobileid, 0)
	logger.debug "ssssssssssssssssssssssssshit"
      end
    end
   }
  end


# Deletions
  if !mobile_data.nil?
   mobile_data.each_index{|i|

    remainder = i % 9

    if remainder == 0
    	trxtype = mobile_data[i]
    end
    if remainder == 1
	trxdatetime = mobile_data[i]
    end
    if remainder == 2
	trxmobileid = mobile_data[i]
    end
    if remainder == 3
    	trxamount = mobile_data[i]
    end
    if remainder == 4
    	trxdateOccured = mobile_data[i]
    end
    if remainder == 5
    	trxcategory = mobile_data[i]
    end
    if remainder == 6
    	trxsubcategory = mobile_data[i]
    end
    if remainder == 7
    	trxttype = mobile_data[i]
    end
    if remainder == 8
    	trxmethod = mobile_data[i]
    end 

    if (remainder == 8 and trxtype == 'D')
     @expense =  Expense.find_by_mobileid(trxmobileid)
	if @expense
#    logger.debug "#{Time.parse(trxdatetime).getutc}"
#    logger.debug "#{@expense.updated_at}"
	
#	   if @expense.updated_at < Time.parse(trxdatetime).getutc
		if @expense.destroy
#   		      response.push(@expense.mobileid, @expense.id)
      		else
#         	      response.push(@expense.mobileid, 0)
		end
#	   end

	end
    end
   }
  
  end 

  # Updates
  if !mobile_data.nil?
   mobile_data.each_index{|i|

    remainder = i % 9

    if remainder == 0
    	trxtype = mobile_data[i]
    end
    if remainder == 1
	trxdatetime = mobile_data[i]
    end
    if remainder == 2
	trxmobileid = mobile_data[i]
    end
    if remainder == 3
    	trxamount = mobile_data[i]
    end
    if remainder == 4
    	trxdateOccured = mobile_data[i]
    end
    if remainder == 5
    	trxcategory = mobile_data[i]
    end
    if remainder == 6
    	trxsubcategory = mobile_data[i]
    end
    if remainder == 7
    	trxttype = mobile_data[i]
    end
    if remainder == 8
    	trxmethod = mobile_data[i]
    end 

 
    if (remainder == 8 and trxtype == 'U')
      @expense =  Expense.find_by_mobileid(trxmobileid)
	if @expense 
#     logger.debug "#{Time.zone}"
#     logger.debug "#{Time.parse(trxdatetime)}"
    logger.debug "#{@expense.updated_at}"
     logger.debug "#{Time.zone.parse(trxdatetime)}"
	   if @expense.updated_at < Time.zone.parse(trxdatetime)
		category_id = Category.where('user_id = ? AND code = ?', user_id, trxcategory).first.id
		subcategory_id = Subcategory.where('user_id = ? AND category_id = ? AND subcategory_code = ?', user_id, category_id, trxsubcategory).first.id
#		if @expense.updated_at < Time.parse(trxdatetime).getutc
		if @expense.update_attributes(:amount => trxamount, :dateoccured => trxdateOccured, :category_id => category_id, :subcategory_id => subcategory_id, :ttype => trxttype, :method =>trxmethod, :mobileid =>trxmobileid, :updated_at => Time.zone.parse(trxdatetime), :sync => "S") 
#   		      response.push(@expense.mobileid, @expense.id)
      		else
#         	      response.push(@expense.mobileid, 0)
		end
	   end
	end
    end

   }
  end


  @expense_journal = ExpenseJournal.all
  @expense_journal = ExpenseJournal.where(:user_id => user_id)
  #  if !@expense_journal.nil?
  unless @expense_journal.empty?
      response.push('web')
#     logger.debug "#{@expense_journal}"
    @expense_journal.each do |expense|
   	response.push(expense.trxtype, expense.trxdatetime.to_formatted_s(:db), expense.sn, expense.amount, expense.dateoccured.to_formatted_s(:db).gsub!('-','/'), expense.category, expense.subcategory, expense.exptype, expense.expmethod)
#         response.push(expense.trxtype, expense.trxdatetime, expense.sn, expense.amount, expense.dateoccured.to_formatted_s(:db).gsub!('-','/'), expense.category, expense.subcategory, expense.exptype, expense.expmethod)
         expense.destroy
    end 
  end 

  return response

 end

 def get_mobile_updates_second_step(mobile_data_2)
 # Update mobile_id
  logger.debug "#{mobile_data_2}"

  webid = 0

  if !mobile_data_2.nil?
   mobile_data_2.each_index{|i|

    remainder = i % 2

    if remainder == 0
    	webid = mobile_data_2[i]
    end
    if remainder == 1
	mobid = mobile_data_2[i]
#	if Expense.exists?(webid)
#	   @expense =  Expense.find(webid)
#	   @expense.update_attributes(:mobileid =>mobid) 
	 begin
   	   @expense =  Expense.find(webid)
	   @expense.update_attributes(:mobileid =>mobid, :sync => "S") 
	   rescue ActiveRecord::RecordNotFound
 	 end
    end
#	if !@expense.nil?
#	   @expense.update_attributes(:mobileid =>mobid) 
#	end

   }
  end
 end

 def get_full_updates(user_id)
	
  response = Array.new
  subcategory_code = ''
  @expense_all = Expense.where(:user_id => user_id)
  unless @expense_all.empty?
      response.push('expenses')
    @expense_all.each do |expense|
	if !expense.subcategory_id.nil? 
		subcategory_code = Subcategory.where(:id => expense.subcategory_id).first.subcategory_code
	else
	     	subcategory_code = ''
       	end
   	response.push(expense.id, expense.amount, expense.dateoccured.to_formatted_s(:db).gsub!('-','/'),  Category.where(:id => expense.category_id).first.code, subcategory_code, expense.ttype, expense.method, expense.updated_at.to_formatted_s(:db))
    end
  end 

  @category_all = Category.where(:user_id => user_id)
  unless @category_all.empty? 
      response.push('categories')
    @category_all.each do |category|
	    response.push(category.code, category.ttype, category.endescription, category.eldescription)
    end
  end 

  @subcategory_all = Subcategory.where(:user_id => user_id)
  unless @subcategory_all.empty?
      response.push('subcategories')
    @subcategory_all.each do |subcategory|
   	response.push(Category.where(:id => subcategory.category_id).first.code, subcategory.subcategory_code, subcategory.ttype, subcategory.enDescription, subcategory.elDescription)
    end
  end 

  return response

 end

  def update_user_id(user_id)
  logger.debug "#{@expense_all_nil_user}"
  @expense_all_nil_user = Expense.where(:user_id => nil)
  unless @expense_all_nil_user.empty?
    @expense_all_nil_user.each do |expense|
  logger.debug "---------------------------------------------#{expense}"
   	expense.update_attributes(:user_id => user_id) 
    end
  end 
 end

end
