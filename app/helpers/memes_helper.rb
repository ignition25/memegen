module MemesHelper
	def getTemplatePath template
		return Memegen::Application::TEMPLATE_DIR + template.path
	end
end
