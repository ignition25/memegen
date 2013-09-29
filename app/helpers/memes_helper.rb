module MemesHelper
	def getTemplatePath template
		return Memegen::Application::TEMPLATE_DIR + template.path
	end

	def getMemePath meme
		return "/generated/" + meme.id.to_s + ".jpg"
	end
end
