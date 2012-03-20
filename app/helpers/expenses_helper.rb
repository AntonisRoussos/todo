module ExpensesHelper

def get_mobile_updates(mobile_data)
	
  response = Array.new

  trxtype = ''
  trxamount = 0
  trxdateOccured = 0
  trxcategory = ''
  trxsubcategory = '' 
  trxttype = ''
  trxmethod = ''
  trxwebid = 0

  mobile_data.each_index{|i|

    remainder = i % 9

    if remainder == 0
    	trxtype = mobile_data[i]
     end
    if remainder == 2
	    trxwebid = mobile_data[i]
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
    	@expense = Expense.new(:amount => trxamount, :dateOccured => trxdateOccured, :category => trxcategory, :subcategory => trxsubcategory, :ttype => trxttype, :method =>trxmethod, :webid =>trxwebid)
      if @expense.save
         response.push(@expense.webid, @expense.id)
      else
         response.push(@expense.webid, 0)
      end
    end

  }

  return response

end	

end
