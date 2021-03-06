<style type="text/css">
        .row-highlight {background-color: Yellow;}
	.row-white {background-color: white;}
	.active-row
.rowLayout label {width:100px;float:left;}
</style>

 <%= stylesheet_link_tag 'blueprint/screen', :media => 'screen' %>


<%= javascript_include_tag 'tasklistview' %>  

<script type="text/javascript">

$(".pagination a").click(function (event) {
    		 event.preventDefault();
		 var id = $(this).attr('href');
		 $('#task_information').empty().load(id);
       		 $('#task-details').empty();
});


//$("#tbl").delegate('click', '.edit a', c=function(event){
$(".edit a").bind('click', c=function(event) {
//$(".edit a").click(c=function (event) {
		event.preventDefault();
		var oldDesc;
		var olddDue;
		var oldPriority;
                 var tr = $('#tbl').find('tr');
		 tr.unbind('mouseenter').unbind('mouseleave');
		 $("#task_due").attr('disabled', 'disabled');
		 $("#task_description").attr('disabled', 'disabled');
		 $("#task_priority").attr('disabled', 'disabled');
	//	 tr.removeClass('row-highlight');
	//		 if bluerow == true {tr.addClass('gridtable');}	
		 $(".edit a").unbind('click');


                     var tds = $('tr.active-row').find(' td');

                     $.each(tds, function(index, item) {
	 			if (index==2) {oldDescription = item.innerHTML;}
  				if (index==1) {oldDue = item.innerHTML;}
  				if (index==4) {oldPriority = item.innerHTML;}
                     });


		 var href = $(this).attr('href');
		 var i1 = href.indexOf("tasks");
		  var i1 = i1 + 6;
		 var i2 = href.indexOf("edit");
		 var i2 = i2 - 1;
		 var taskid = href.slice(i1, i2);
		 var values = '';
		 $('#task-details').addClass('task-info'); 
		  values = values + '<form accept-charset="UTF-8" action="/tasks/update" class="task_edit" data-remote="true" id="edit_task" method="post">';
		  values = values + '<input id="task_id" name="task[id]" value=' + taskid + ' type="hidden" />';
		  values = values + '<div class="rowLayout">';
		 values = values + '<label>'+I18n.t("javascripts.Description")+'</label>';  
		  values = values + '<input id="task_description" maxlength="30" name="task[description]" size="30" type="text" value ="' + oldDescription + '" />';
		 values = values +  '</div>';
		  values = values + '<div class="rowLayout">';
		 values = values + '<label>'+I18n.t("javascripts.Due")+'</label>'; 
		  values = values + '<input id="task_due" maxlength="10" name="task[due]" size="10" type="text" value ="' + oldDue + '" />';
		 values = values +  '</div>';
		  values = values + '<div class="rowLayout">';
		 values = values +  '<label>'+I18n.t("javascripts.Priority")+'</label>';
		  values = values + '<input id="task_priority" maxlength="1" name="task[priority]" size="1" type="text" value ="' + oldPriority + '" />';
		 values = values +  '</div>';
                 values = values + '<input id="task_submit" name="commit" type="submit" value="Update" />';
		 values = values + '</form>'; 
//		 values = values + '<script type="text/javascript">' + $("#task_due").datepicker(); + '</script>';


// 		  values = values + '<form accept-charset="UTF-8" action="/tasks/update" class="task_edit" data-remote="true" id="edit_task" method="post">';
//		  values = values + '<input id="task_id" name="task[id]" value=' + taskid + ' type="hidden" />';
//		  values = values + I18n.t("javascripts.Description");  
//		  values = values + '<input id="task_description" maxlength="30" name="task[description]" size="30" type="text" value ="' + oldDescription + '" />' + '<br/>';
//		  values = values + I18n.t("javascripts.Due"); 
//		  values = values + '<input id="task_due" maxlength="19" name="task[due]" size="19" type="text" value ="' + oldDue + '" />' + '<br/>';
//		  values = values + I18n.t("javascripts.Priority"); 
//		  values = values + '<input id="task_priority" maxlength="1" name="task[priority]" size="1" type="text" value ="' + oldPriority + '" />' + '<br/>';
// 		  values = values + '<input id="task_submit" name="commit" type="submit" value="Update" />';
//		  values = values + '</form>';
		  $('#task-details').empty().html(values);
	  	  //	 $("#tbl").undelegate('click', '.edit a', c);
//                 var id = $(this).attr('href');
	//		 $('#task-details').empty().load(id, function()
	//                 {$('#description').focus();});
	//	 $('#task-details').empty().load(id);
});

$(document).ready(function() {
	//		$( "#tab-container" ).bind( "tabsselect", function() {
		$('#task-details').removeClass('task-info'); 
		$('#task-details').empty();

});


</script>

<table id="tbl">
<!-- col style="{visibility: collapse;}" / -->
<% @tasks.each do |task| %>
    <tr CLASS="gridtable">
      <td CLASS="id" style="display: none"><%= task.id %></td>
      <td CLASS="originaldue" style="display: none"><%= task.due.to_s[0,10] %></td>
      <td CLASS="desc" id="desc"><%= task.description %></td>
      <td CLASS="due" id="due"><%= @day[task.due.wday] + " " + task.due.strftime("%d") + "/" + task.due.strftime("%m")+ "/" + task.due.strftime("%y") %></td>
      <td CLASS="prior" id="prior"><%= task.priority %></td>
      <td CLASS="prior edit"><%= link_to t(:Edit), edit_task_path(task), :remote => true %></td>
      <td CLASS="prior destroy"><%= link_to t(:Destroy), task, :confirm => t(:Are_you_sure?), :method => :delete, :remote => true %></td>
   </tr>
  <% end %>
</table>

<%= will_paginate @tasks %>

 <!-- %= will_paginate @tasks, :renderer => RemoteLinkRenderer % -->




