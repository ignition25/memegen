class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	before_filter :update_sanitized_params, if: :devise_controller?

	def not_found_error
		raise ActionController::RoutingError.new('Not Found')
	end

	def forbidden_access_error
		raise ActionController::RoutingError.new('Forbidden')
	end 

	def update_sanitized_params
	  devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :username, :remember_me)}
	end

	# Overwrite _path methods to use key instead of id.

	def group_meme_path(group, meme, options={})
	  group_meme_url(group, meme, options.merge(:only_path => true))
	end

	def group_meme_url(group, meme, options={})
	  url_for(options.merge(:controller => 'memes', :action => 'show',
	                        :group_id => group.key, :id => meme.key))
	end

	def meme_path(meme)
		return memes_path << "/" << meme.key
	end
end
