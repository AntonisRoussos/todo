$(function() {
            var tr = $('#tbl').find('tr');
	    tr.hover(
                 function() {  // mouseover
                    $(this).removeClass('gridtable');
                    $(this).addClass('row-highlight');
                     var values = '';
                     var tds = $(this).find('td');

                     $.each(tds, function(index, item) {
                         values = values + 'td' + (index + 1) + ':' + item.innerHTML + '<br/>';
                     });
                     $('#task-details').html(values);
                 },
                 function() {  // mouseout
                     $(this).removeClass('row-highlight');
//  		     $("#tbl tr:nth-of-type(even)").addClass('gridtable');
  		     $(this).addClass('gridtable');
                     $('#task-details').html('');
                 }
            );
});
