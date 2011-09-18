class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
#class RemoteLinkRenderer < WillPaginate::ActionView::LinkRenderer
   def link(text,target,attributes={})
	attributes ["data-remote"]=true
#	oldurl = url(target)
#	url(target) << "javascript:loadContent('#task_information',"+:oldurl+")"
#	Rails.logger.debug("-----   ----------------------------------------url")
#	Rails.logger.debug("#{url(target)}")
#	super
  end

end

