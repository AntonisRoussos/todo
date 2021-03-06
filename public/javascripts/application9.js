// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function () {

$("#task-details").submit({desc: '#edit_task #task_description', due: '#edit_task #task_due1', prior: '#edit_task #task_priority'}, function(event) {
//	         event.preventDefault();
                 var tr = $('#tbl').find('tr');

//		 alert($(event.data.desc).attr('value'));
//		 alert($(event.data.due).attr('value'));
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
//		 task.description = $(event.data.desc).attr('value')
		 tr.bind('mouseenter', a).bind('mouseleave', b);
		 $(".edit a").bind('click', c);
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


$("#task_due1").live("click",function(){
     
    //$(this).datepicker({ dateFormat: 'yy-mm-dd' }).focus();
       $(this).datepicker().focus();
//       return(false);


});


$("#task_due:not(.datepicker)").datepicker();

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

});

