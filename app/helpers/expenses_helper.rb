module ExpensesHelper

def insert_to_expenses_journal(operation, expense)

	@expense_journal = ExpenseJournal.new({:trxtype => operation, :trxdatetime => Time.now, :sn => expense.id, :amount => expense.amount, :dateoccured => expense.dateOccured, :category => expense.category, :subcategory => expense.subcategory, :exptype => expense.ttype, :expmethod =>expense.method})
		@expense_journal.save

end

def get_mobile_updates(mobile_data)
	
  response = Array.new

  trxtype = ''
  trxamount = 0
  trxdateOccured = 0
  trxcategory = ''
  trxsubcategory = '' 
  trxttype = ''
  trxmethod = ''
  trxmobileid = 0
  trxdatetime = ''

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
    	@expense = Expense.new(:amount => trxamount, :dateOccured => trxdateOccured, :category => trxcategory, :subcategory => trxsubcategory, :ttype => trxttype, :method =>trxmethod, :mobileid =>trxmobileid, :created_at => Time.parse(trxdatetime).getutc, :updated_at => Time.parse(trxdatetime).getutc, :sync => "S")
      if @expense.save
         response.push(@expense.mobileid, @expense.id)
      else
         response.push(@expense.mobileid, 0)
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
#     logger.debug "#{Time.zone.parse(trxdatetime)}"
#     logger.debug "#{Time.parse(trxdatetime)}"
#    logger.debug "#{@expense.updated_at}"
	   if @expense.updated_at < Time.zone.parse(trxdatetime)
#	   if @expense.updated_at < Time.parse(trxdatetime).getutc
		if @expense.update_attributes(:amount => trxamount, :dateOccured => trxdateOccured, :category => trxcategory, :subcategory => trxsubcategory, :ttype => trxttype, :method =>trxmethod, :mobileid =>trxmobileid, :updated_at => Time.zone.parse(trxdatetime), :sync => "S") 
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
	   @expense.update_attributes(:mobileid =>mobid) 
	   rescue ActiveRecord::RecordNotFound
 	 end
    end
#	if !@expense.nil?
#	   @expense.update_attributes(:mobileid =>mobid) 
#	end

   }
  end
 end

end