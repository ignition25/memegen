module ApplicationHelper
	def nav_newest_button(link_text, link_path)
		class_name = ((current_page?(link_path) or current_page?(memes_path)) and params[:sort].nil?) ? 'btn btn-success active' : 'btn btn-default'
		content_tag(:a, link_text, href: link_path, class: class_name)
	end

	def nav_sort_button(link_text, link_path, sort_by)
		class_name = (current_page?(link_path) and params[:sort] == sort_by) ? 'btn btn-success active' : 'btn btn-default'
		content_tag(:a, link_text, href: link_path, class: class_name)
	end

end
