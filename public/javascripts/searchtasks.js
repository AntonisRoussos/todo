$('#select_origin').autocomplete({
 // This shows the min length of charcters that must be typed before the autocomplete looks for a match.
            minLength: 2,
 // This is the source of the autocomplete suggestions. In this case a list of names from the tasks controller, in JSON format.
            source: '<%= task_path(:json) %>',
  // This updates the textfield when you move the updown the suggestions list, with your keyboard. In our case it will reflect the same value that you see in the suggestions which is the person.given_name.
//            focus: function(event, ui) {
//                $('#select_origin').val(ui.item.person.given_name);
//                return false;
//            },
 // Once a value in the drop down list is selected, do the following:
            select: function(event, ui) {
 // place the person.given_name value into the textfield called 'select_origin'...
                $('#select_origin').val(ui.item.person.given_name);
 // and place the person.id into the hidden textfield called 'link_origin_id'. 
        $('#link_origin_id').val(ui.item.person.id);
                return false;
            }
        })
 // The below code is straight from the jQuery example. It formats what data is displayed in the dropdown box, and can be customized.
        .data( "autocomplete" )._renderItem = function( ul, item ) {
            return $( "<li></li>" )
                .data( "item.autocomplete", item )
 // For now which just want to show the person.given_name in the list.
                .append( "<a>" + item.person.given_name + "</a>" )
                .appendTo( ul );
        };
    });
    </script>



<h1>New link</h1>

<% form_for(@link) do |f| %>
  <%= f.error_messages %>

<!-- Place the following text fields in your form, the names are not important. What is important is that they match the names in your javascript above -->
  <p>
        Select which person you want to link:<br /> 
<!-- This is the textfield that will autocomplete. What is displayed here is for the user to see but the data will not go anywhere -->
        <input id="select_origin"/>
<!-- This is the hidden textfield that will be given the Persons ID based on who is selected. This value will be sent as a parameter -->
      <input id="link_origin_id" name="link[origin_id]" type="hidden"/>
  </p>
<!-- end of notes -->
  <p>
    <%= f.label :rcvd_id %><br />
    <%= f.text_field :rcvd_id %>
  </p>
  <p>
    <%= f.label :link_type %><br />
    <%= f.text_field :link_type %>
  </p>
  <p>
    <%= f.label :summary %><br />
    <%= f.text_area :summary %>
  </p>
  <p>
    <%= f.label :active %><br />
    <%= f.check_box :active %>
  </p>
  <p>
    <%= f.submit 'Create' %>
  </p>
<% end %>

