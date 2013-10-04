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
		class_name = (current_page?(memes_path) and params[:group] == group.key) ? 'btn btn-success active' : 'btn btn-default'
		link_path = memes_path << "?group=" << group.key
		content_tag(:a, group.name, href: link_path, class: class_name)
	end

end
