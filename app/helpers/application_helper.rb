module ApplicationHelper
	def nav_newest_button(link_text, link_path)
		class_name = ((current_page?(link_path) or current_page?(memes_path)) and params[:sort].nil? and params[:group].nil?) ? 'btn btn-success active' : 'btn btn-default'
		content_tag(:a, link_text, href: link_path, class: class_name)
	end

	def nav_sort_button(link_text, link_path, sort_by)
		class_name = (current_page?(link_path) and params[:sort] == sort_by) ? 'btn btn-success active' : 'btn btn-default'
		content_tag(:a, link_text, href: link_path, class: class_name)
	end

	def nav_group_button(group)
		class_name = (current_page?(group_path(group))) ? 'btn btn-success active' : 'btn btn-default'
		link_path = group_path(group)
		content_tag(:a, group.name, href: link_path, class: class_name << " group-selector") # do
			# content_tag(:span, group.name) + content_tag(:i, "", class: "glyphicon glyphicon-cog group-settings-icon")
		# end
	end

	def echo_group_visibility(group)
		return "#{group.name} is a " << ((group.visibility == 'private') ? "private group" : "hidden (link-only) group") << "."
	end

	# Overwrite _path methods to use key instead of id.
	def new_group_meme_path(group, options={})
	  new_group_meme_url(group, options.merge(:only_path => true))
	end

	def new_group_meme_url(group, options={})
	  url_for(options.merge(:controller => 'memes', :action => 'new',
	                        :group_id => group.key))
	end

	def group_path(group, options={})
	  group_url(group, options.merge(:only_path => true))
	end

	def group_url(group, options={})
	  url_for(options.merge(:controller => 'groups', :action => 'show',
	                        :id => group.key))
	end

	def meme_path(meme, options={})
	  meme_url(meme, options.merge(:only_path => true))
	end

	def meme_url(meme, options={})
	  url_for(options.merge(:controller => 'memes', :action => 'show',
	                        :id => meme.key))
	end

end
