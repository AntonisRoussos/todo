$(function() {
            var tr = $('#tbl').find('tr');
	    tr.hover(
                  a=function() {  // mouseover
//                    previous.removeClass('row-highlight');
                    $(this).removeClass('gridtable');
                    $(this).addClass('row-highlight');
		    $(this).addClass('active-row');
                     var values = '';
                     var tds = $(this).find('td');

                     $.each(tds, function(index, item) {
//                         values = values + 'td' + (index + 1) + ':' + item.innerHTML + '<br/>';
	 			if (index==1) {values = values + I18n.t("javascripts.Description") + item.innerHTML + '<br/>';}
  				if (index==2) {values = values + I18n.t("javascripts.Due") + item.innerHTML + '<br/>';}
  				if (index==3) {values = values + I18n.t("javascripts.Priority") + item.innerHTML + '<br/>';}
                     });
                     $('#task-details').html(values);
                 },
                  b=function() {  // mouseout
		     $(this).removeClass('row-highlight');
		     $(this).removeClass('active-row');
//  		     $("#tbl tr:nth-of-type(even)").addClass('gridtable');
  		     $(this).addClass('gridtable');
                     $('#task-details').html('');
                 }
            );
});
