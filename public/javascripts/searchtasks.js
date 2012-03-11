$('#search').autocomplete({
 		// This shows the min length of charcters that must be typed before the autocomplete looks for a match.
            minLength: 2,
 		// This is the source of the autocomplete suggestions. In this case a list of names from the tasks controller, in JSON format.
            source: '<%= tasks_path(:json) %>',
  // This updates the textfield when you move the updown the suggestions list, with your keyboard. In our case it will reflect the same value that you see in the suggestions which is the person.given_name.
//            focus: function(event, ui) {
//                $('#select_origin').val(ui.item.person.given_name);
//                return false;
//            },
 // Once a value in the drop down list is selected, do the following:
 //           select: function(event, ui) {
//			 // place the person.given_name value into the textfield called 'select_origin'...
//          	      $('#select_origin').val(ui.item.person.given_name);
//			 // and place the person.id into the hidden textfield called 'link_origin_id'. 
//       			 $('#link_origin_id').val(ui.item.person.id);
//               		 return false;
//            }
        })
 // The below code is straight from the jQuery example. It formats what data is displayed in the dropdown box, and can be customized.
        $('#task_information).data( "autocomplete" )._renderItem = function( ul, item ) {
            return $( "<li></li>" )
                 $('#task_information).data( "item.autocomplete", item )
 // For now which just want to show the person.given_name in the list.
                 $('#task_information).append( "<a>" + item.task.description + "</a>" )
                 $('#task_information).appendTo( ul );
        };
    });

