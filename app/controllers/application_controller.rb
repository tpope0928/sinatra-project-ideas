require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_project_ideas_app"
    register Sinatra::Flash
  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorized_to_edit?(project_idea)
      project_idea.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end
    end

    #add helper so users cannot have more than one claimed idea

  end

end
