// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function () {

$("#task-details").submit({
			  	desc: '#edit_task #task_description', due: '#edit_task #task_due1', prior: '#edit_task #task_priority',
			  	type: '#edit_task #task_ttype', stat: '#edit_task #task_status', statusdate: '#edit_task #task_status_date',
			  	budget: '#edit_task #task_budget', longdes: '#edit_task #task_long_description'
			  },
function(event) {
                 var tr = $('#tbl').find('tr');
$.ajax({
  	url: "/tasks/retrieve_day",
  	type: "GET",
  	data: {date : $(event.data.due).attr('value')},
  	dataType: "xml",
    	async: false,
	success:function(rdata) {
				$(rdata).find("Response").each(function()
					{$('tr.active-row td').filter('#due').replaceWith('<td CLASS="due" id="due">'+$(this).find("Date").text()+'</td>');});
				}
});
		 $('tr.active-row td').filter('#desc').replaceWith('<td CLASS="desc" id="desc">'+$(event.data.desc).attr('value')+'</td>');
		 $('tr.active-row td').filter('#prior').replaceWith('<td CLASS="prior" id="prior">'+$(event.data.prior).attr('value')+'</td>');
                 $('tr.active-row td').filter('#olddue').replaceWith('<td CLASS="olddue" id="olddue" style="display: none">'+$(event.data.due).attr('value')+'</td>');
                 $('tr.active-row td').filter('#ttype').replaceWith('<td CLASS="ttype" id="ttype" style="display: none">'+$(event.data.type).attr('value')+'</td>');
                 $('tr.active-row td').filter('#status').replaceWith('<td CLASS="status" id="status" style="display: none">'+$(event.data.stat).attr('value')+'</td>');
                 $('tr.active-row td').filter('#status_date').replaceWith('<td CLASS="status_date" id="status_date" style="display: none">'+$(event.data.statusdate).attr('value')+'</td>');
                 $('tr.active-row td').filter('#budget').replaceWith('<td CLASS="budget" id="budget" style="display: none">'+$(event.data.budget).attr('value')+'</td>');
                 $('tr.active-row td').filter('#long_description').replaceWith('<td CLASS="long_description" id="long_description" style="display: none">'+$(event.data.longdes).attr('value')+'</td>');
//		 task.description = $(event.data.desc).attr('value')
		 tr.bind('mouseenter', a).bind('mouseleave', b);
		 $(".edit a").bind('click', c);
	//	 $(".destroy a").bind('click');
	//	 $("a").click(function(){return true;})
	//	 $("#tbl").delegate('click', '.edit a', c);
	 	 //		 bluerow = $('tr.active-row').hasClass("gridtable")
	//	 $("tr:even").css("background-color", "#e5ecf9");
		 tr.removeClass('row-highlight');
		 tr.removeClass('active-row');
        //         $("#tbl tr:nth-of-type(even)").addClass('gridtable');
   		 tr.addClass('gridtable');
                 $('#task-details').removeClass('task-info'); 
		 $('#task-details').empty();
		 $("#task_due").removeAttr('disabled');
		 $("#task_description").removeAttr('disabled');
		 $("#task_priority").removeAttr('disabled');
});

$("#expense-details").submit({
			  	amount: '#edit_expense #expense_amount', dateoccured: '#update-expense-date', categoryid: '#edit_expense #expense_id',
			  	subcategoryid: '#edit_expense #expense_subcategory_id', method: '#edit_expense #expense_method'
			  },
function(event) {
                 var tr = $('#tbl').find('tr');
$.ajax({
  	url: "/tasks/retrieve_day",
  	type: "GET",
  	data: {date : $(event.data.dateoccured).attr('value')},
  	dataType: "xml",
    	async: false,
	success:function(rdata) {
				$(rdata).find("Response").each(function()
					{$('tr.active-row td').filter('#expdate').replaceWith('<td CLASS="originaldateOccured" id="expdate">'+$(this).find("Date").text()+'</td>');});
				}
});
		 $('tr.active-row td').filter('#expamount').replaceWith('<td CLASS="expamount" id="expamount">'+$(event.data.amount).attr('value')+'</td>');
                 $('tr.active-row td').filter('#originaldateOccured').replaceWith('<td CLASS="originaldateOccured" id="originaldateOccured" style="display: none">'+$(event.data.dateoccured).attr('value')+'</td>');
		 $('tr.active-row td').filter('#expcategory').replaceWith('<td CLASS="expcategory" id="expcategory">'+$("select[id='update-expense-category'] option:selected").html()+'</td>');
		 $('tr.active-row td').filter('#expsubcategory').replaceWith('<td CLASS="expsubcategory" id="expsubcategory">'+$("select[id='update-expense-subcategory'] option:selected").html()+'</td>');
		 $('tr.active-row td').filter('#expmethod').replaceWith('<td CLASS="expmethod" id="expmethod">'+$(event.data.method).attr('value')+'</td>');
		 tr.bind('mouseenter', a).bind('mouseleave', b);
		 $(".edit a").bind('click', c);
		 tr.removeClass('row-highlight');
		 tr.removeClass('active-row');
   		 tr.addClass('gridtable');
                 $('#expense-details').removeClass('expense-info'); 
		 $('#expense-details').empty();
		 $("#expense_amount").removeAttr('disabled');
		 $("#expense_dateoccured").removeAttr('disabled');
		 $("#expense_category_id").removeAttr('disabled');
		 $("#expense_subcategory_id").removeAttr('disabled');
		 $("#expense_method").removeAttr('disabled');
});

$("#task_due1").live("click",function(){
     
    //$(this).datepicker({ dateFormat: 'yy-mm-dd' }).focus();
       $(this).datepicker().focus();
//       return(false);


});

$("#update-expense-date").live("click",function(){
    //$(this).datepicker({ dateFormat: 'yy-mm-dd' }).focus();
       $(this).datepicker().focus();
//       return(false);


});


$("#task_due:not(.datepicker)").datepicker();
$("#expense_dateoccured:not(.datepicker)").datepicker();
$("#dateoccuredfrom:not(.datepicker)").datepicker();
$("#dateoccuredto:not(.datepicker)").datepicker();

$("#new_user").validate({
rules: {
"user[name]": {required: true, maxlength: 23, remote: "/signup/users/check_name"},	
"user[email]": {required: true, maxlength: 45, email: true, remote: "/signup/users/check_email"}, 
"user[password]": {required: true, minlength: 6, maxlength: 20},
"user[password_confirmation]": {required: true, equalTo: "#user_password"}
},
messages: {
    "user[email]": {
    required: I18n.t("javascripts.emailmissing"),
    email: I18n.t("javascripts.validemail"),
    maxlength: I18n.t("javascripts.maximum_email_length_is_45"),
    remote: I18n.t("javascripts.existingemail")
},
    "user[name]": {
    required:  I18n.t("javascripts.name_is_missing"),
    remote: I18n.t("javascripts.This_name_is_already_allocated_by_another_user"),
    maxlength: I18n.t("javascripts.maximum_user_name_length_is_23")
},
    "user[password]": {
    required:  I18n.t("javascripts.password_is_missing"),
    minlength: I18n.t("javascripts.minimum_password_length_is_6"),
    maxlength: I18n.t("javascripts.maximum_password_length_is_20")
},
    "user[password_confirmation]": {
    required:  I18n.t("javascripts.password_confirmation_is_missing"),
    equalTo: I18n.t("javascripts.confirmation_password_should_be_equal_to_password") 
}
}
});
$("#reset_password").validate({
rules: {
"user[password]": {required: true, minlength: 6, maxlength: 20},
"user[password_confirmation]": {required: true, equalTo: "#user_password"}
},
messages: {
    "user[password]": {
    required:  I18n.t("javascripts.Please_give_your_new_password")
},
    "user[password_confirmation]": {
    required:  I18n.t("javascripts.Please_give_your_new_password"),
    equalTo: I18n.t("javascripts.Please_give_the_same_password") 
}
}
});
$("#change_password").validate({
rules: {
"existinguserpassword": {required: true, minlength: 6, maxlength: 20},
"user[password]": {required: true, minlength: 6, maxlength: 20, notEqualTo: "#existing_user_password"},
"user[password_confirmation]": {required: true, equalTo: "#user_password"}
},
messages: {
    "existinguserpassword": {
    required: I18n.t("javascripts.Your_existing_password_is_missing")
},
    "user[password]": {
    required:  I18n.t("javascripts.Please_give_your_new_password"),
    notEqualTo: I18n.t("javascripts.Please_give_a_different_password") 
},
    "user[password_confirmation]": {
    required:  I18n.t("javascripts.Please_give_your_new_password"),
    equalTo: I18n.t("javascripts.Please_give_the_same_password") 
}
}
});
$("#edit_user").validate({
rules: {
"user[name]": {required: true, maxlength: 23, remote: { url: "/signup/users/check_name", data: { id: $("#user_id").val()}}},	
"user[email]": {required: true, maxlength: 45, email: true, remote: { url: "/signup/users/check_email", data: { id: $("#user_id").val()}}}
},
messages: {
    "user[email]": {
    required: I18n.t("javascripts.emailmissing"),
    email: I18n.t("javascripts.validemail"),
    maxlength: I18n.t("javascripts.maximum_email_length_is_45"),
    remote: I18n.t("javascripts.existingemail")
},
    "user[name]": {
    required:  I18n.t("javascripts.name_is_missing"),
    remote: I18n.t("javascripts.This_name_is_already_allocated_by_another_user") 
}
}
});
$("#newexpense").validate({
rules: {
"expense[amount]": {required: true, maxlength: 10},
"expense[dateoccured]": {required: true, remote: { url: "/expenses/check_date_due", data: { id: $("#expense_dateoccured").val()}}}
},
messages: {
    "expense[amount]": {
    required:  I18n.t("javascripts.Please_give_expense_amount")
},
    "expense[dateoccured]": {
    required:  I18n.t("javascripts.Please_give_task_date"),
    date:  I18n.t("javascripts.Wrong_date_format"),
    remote: I18n.t("javascripts.Wrong_date_format")
}
}
});

$("#newtask").validate({
rules: {
"task[description]": {required: true, maxlength: 30},
//"task[due]": {required: true, date: true,  remote: { url: "/tasks/check_date_due", data: { id: $("#task_due").val()}}},
"task[due]": {required: true, remote: { url: "/tasks/check_date_due", data: { id: $("#task_due").val()}}},
"task[priority]": {required: true}
},
messages: {
    "task[description]": {
    required:  I18n.t("javascripts.Please_give_task_description")
},
    "task[due]": {
    required:  I18n.t("javascripts.Please_give_task_date"),
    date:  I18n.t("javascripts.Wrong_date_format"),
    remote: I18n.t("javascripts.Wrong_date_format")
},
    "task[priority]": {
    required:  I18n.t("javascripts.Please_give_task_priority")
}
}
});

$("#Infoform").validate({
rules: {
"dateoccuredfrom": {required: true, remote: { url: "/expenses/check_date_due_from"}},
"dateoccuredto": {required: true, remote: { url: "/expenses/check_date_due_to"}},
},
messages: {
    "dateoccuredfrom": {
    required:  I18n.t("javascripts.Please_give_task_date"),
    date:  I18n.t("javascripts.Wrong_date_format"),
    remote: I18n.t("javascripts.Wrong_date_format")
},
    "dateoccuredto": {
    required:  I18n.t("javascripts.Please_give_task_date"),
    date:  I18n.t("javascripts.Wrong_date_format"),
    remote: I18n.t("javascripts.Wrong_date_format")
}
}
});

$("#add-expense-category").live("change", function (){
          var str = "";
          $("select[id='add-expense-category'] option:selected").each(function () {
                str += $(this).val() + " ";
              });

        $.ajax({
            url: "/expenses/getSubcategories", type: "GET", dataType: "script",
            data: { category: str },
            async: true,
            success: function(msg) {
                $("#add-expense-subcategory").get(0).options.length = 0;
//                $("#add-expense-subcategory").get(0).options[0] = new Option("Subcategory", "-1"); 
			var msg1 = jQuery.parseJSON(msg); 
 		
			$.each(msg1, function(index, item) {
				$("#add-expense-subcategory").get(0).options[$("#add-expense-subcategory").get(0).options.length] = new Option(item.eldescription, item.id);
			});
            },
            error: function() {
                $("#add-expense-subcategory").get(0).options.length = 0;
            }
        });
 
})
        .change();
$("#update-expense-category").live("change", function (){
          var str = "";
          $("select[id='update-expense-category'] option:selected").each(function () {
                str += $(this).val() + " ";
              });

        $.ajax({
            url: "/expenses/getSubcategories", type: "GET", dataType: "script",
            data: { category: str },
            async: true,
            success: function(msg) {
                $("#update-expense-subcategory").get(0).options.length = 0;
//                $("#update-expense-subcategory").get(0).options[0] = new Option("Subcategory", "-1"); 
			var msg1 = jQuery.parseJSON(msg); 
 		
			$.each(msg1, function(index, item) {
                   	$("#update-expense-subcategory").get(0).options[$("#update-expense-subcategory").get(0).options.length] = new Option(item.eldescription, item.id);
			});
            },
            error: function() {
                $("#update-expense-subcategory").get(0).options.length = 0;
            }
        });
 
    })
        .change();

});

