// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function () {
$("#new_user").validate({
rules: {
"user[name]": {required: true, maxlength: 20, remote: "/signup/users/check_name"},	
"user[email]": {required: true, email: true, remote: "/signup/users/check_email"}, 
"user[password]": {required: true, minlength: 6, maxlength: 20},
"user[password_confirmation]": {required: true, equalTo: "#user_password"}
},
messages: {
    "user[email]": {
    required: I18n.t("javascripts.emailmissing"),
    email: I18n.t("javascripts.validemail"),
    remote: I18n.t("javascripts.existingemail")
},
    "user[name]": {
    required:  I18n.t("javascripts.name_is_missing"),
    remote: I18n.t("javascripts.This_name_is_already_allocated_by_another_user") 
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
"user[name]": {required: true, maxlength: 20, remote: { url: "/signup/users/check_name", data: { id: $("#user_id").val()}}},	
"user[email]": {required: true, email: true, remote: { url: "/signup/users/check_email", data: { id: $("#user_id").val()}}}
},
messages: {
    "user[email]": {
    required: I18n.t("javascripts.emailmissing"),
    email: I18n.t("javascripts.validemail"),
    remote: I18n.t("javascripts.existingemail")
},
    "user[name]": {
    required:  I18n.t("javascripts.name_is_missing"),
    remote: I18n.t("javascripts.This_name_is_already_allocated_by_another_user") 
}
}
});

});

