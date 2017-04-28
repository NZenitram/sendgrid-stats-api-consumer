module Users
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource_or_scope)
      welcome_path
    end
  end
end
