class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
def logger
RAILS_DEFAULT_LOGGER
end

  def link(text,target,attributes={})
#	attributes ["data-remote"]=true
	super
#       logger.debug("#{text}")
#       logger.debug("#{target}")
#       logger.debug("#{attributes}")
  end

end

