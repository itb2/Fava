class SessionsController < ApplicationController

	layout :choose_layout

	def choose_layout
		if request.path_info.include?('/login')
			'userauth'
		else
			'application'
		end
	end


  def new
  end

  def create
  	fava_user = FavaUser.find_by(email: params[:session][:email].downcase)
  	if fava_user && fava_user.authenticate(params[:session][:password])
      if fava_user.activated?
    		# Log in and redirect
    		log_in fava_user
    		redirect_to '/'
      else
        redirect_to signup_path
      end
  	else
  		# Create error message
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end
