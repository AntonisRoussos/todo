class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
#class RemoteLinkRenderer < WillPaginate::ActionView::LinkRenderer
   def link(text,target,attributes={})
	attributes ["data-remote"]=true
#	oldurl = url(target)
#	url(target) << "javascript:loadContent('#task_information',"+:oldurl+")"
#	Rails.logger.debug("  -----   ----------------------------------------url")
#	Rails.logger.debug("#{url(target)}")
#	super
        if target.is_a? Fixnum
          attributes[:rel] = rel_value(target)
          target = url(target)
        end
        attributes[:href] = target
        tag(:a, text, attributes)
  end

end

