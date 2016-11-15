class SessionsController < Devise::SessionsController
  respond_to :js, :html

end