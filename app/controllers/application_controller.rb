class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    my_page_path
  end

end
