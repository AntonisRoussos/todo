// <link rel="stylesheet" type="text/css" href="./stylesheets/blueprint/screen.css">
$(function() {
            var tr = $('#tbl').find('tr');
	    tr.hover(
                  a=function() {  // mouseover
//                    previous.removeClass('row-highlight');
		    $('#expense-details').addClass('expense-info'); 
                    $(this).removeClass('gridtable');
                    $(this).addClass('row-highlight');
		    $(this).addClass('active-row');
                     var values = '';
                     var tds = $(this).find('td');

                     $.each(tds, function(index, item) {
//                         values = values + 'td' + (index + 1) + ':' + item.innerHTML + '<br/>';
	 			if (index==1) {values = values + I18n.t("javascripts.Amount") + item.innerHTML + '<br/>';}
  				if (index==2) {values = values + I18n.t("javascripts.Date") + item.innerHTML + '<br/>';}
  				if (index==3) {values = values + I18n.t("javascripts.Category_description") + item.innerHTML + '<br/>';}
  				if (index==4) {values = values + I18n.t("javascripts.Subcategory_description") + item.innerHTML + '<br/>';}
  				if (index==5) {values = values + I18n.t("javascripts.Method") + item.innerHTML +  '<br/>';
						$('#txt').css("color","red");}
                     });
                     $('#expense-details').html(values);
                 },
                  b=function() {  // mouseout
		    $('#expense-details').removeClass('expense-info'); 
		     $(this).removeClass('row-highlight');
		     $(this).removeClass('active-row');
//  		     $("#tbl tr:nth-of-type(even)").addClass('gridtable');
  		     $(this).addClass('gridtable');
                     $('#expense-details').html('');
                 }
            );
});

$(".editexpense a").on('click', c=function(event) {
	alert('innn');
		var oldexpamount;
		var oldoriginaldateOccured;
		var oldexpcategory;
		var oldexpsubcategory;
		var oldexpmethod;
                 var tr = $('#tbl').find('tr');
		 tr.unbind('mouseenter').unbind('mouseleave');
		 $("#expense_amount").attr('disabled', 'disabled');
		 $("#expense_dateOccured").attr('disabled', 'disabled');
		 $("#expense_category_id").attr('disabled', 'disabled');
		 $("#expense_subcategory_id").attr('disabled', 'disabled');
		 $("#expense_method").attr('disabled', 'disabled');
		 $(".editexpense a").off('click');
                     var tds = $('tr.active-row').find(' td');
                     $.each(tds, function(index, item) {
	 			if (index==2) {oldexpamount = item.innerHTML;}
  				if (index==12) {oldoriginaldateOccured = item.innerHTML;}
  				if (index==4) {oldexpcategory = item.innerHTML;}
  				if (index==7) {oldexpsubcategory = item.innerHTML;}
  				if (index==8) {oldexpmethod = item.innerHTML;}
                    });
});

