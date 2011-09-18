class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  def link(text,target,attributes={})
	attributes ["data-remote"]=true
        if target.is_a? Fixnum
          attributes[:rel] = rel_value(target)
          target = url(target)
        end
        attributes[:href] = target
        tag(:a, text, attributes)
  end

end

