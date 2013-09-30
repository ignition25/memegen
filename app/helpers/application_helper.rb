module ApplicationHelper
	def left_nav_button(link_text, link_path)
	  class_name = current_page?(link_path) ? 'btn btn-success active' : 'btn btn-default'
	  content_tag(:a, link_text, href: link_path, class: class_name)
	end
end
