class ProjectIdeasController < ApplicationController

  get '/project_ideas' do
    @project_idea = ProjectIdea.all.select { |idea| idea.status == false }

    erb :'project_ideas/index'
  end

  get '/project_ideas/new' do
    redirect_if_not_logged_in
    erb :'/project_ideas/new'
  end

  post '/project_ideas' do
    redirect_if_not_logged_in
    if params[:content] != ""
      @project_idea = ProjectIdea.create(content: params[:content], user_id: current_user.id, title: params[:title], status: params[:status])
      flash[:message] = "Project idea successfully created." if @project_idea.id
      redirect "/project_ideas/#{@project_idea.id}"
    else
      flash[:errors] = "Something went wrong - you must provide content for your idea."
      redirect '/project_ideas/new'
    end
    #if params claimed = true then add to show page
    #show as claimed to all projects
    #elsif params claimed != true (unclaimed) then add to all project ideas
    #else flash[:errors] = "Something went wrong - Would you like to claim this project?"
    #redirect '/project_ideas/new'
  end

  get '/project_ideas/:id' do
    set_project_idea
    if set_project_idea.status != false
      erb :'/project_ideas/show'
    else
      redirect :'/project_ideas'
    end

  end

  get '/project_ideas/:id/edit' do
    redirect_if_not_logged_in
    set_project_idea
    if authorized_to_edit?(@project_idea)
      erb :'/project_ideas/edit'
    else
      redirect "users/#{current_user.id}"
    end
  end

  patch '/project_ideas/:id' do
    redirect_if_not_logged_in
    set_project_idea
    if @project_idea.user == current_user && params[:content] != ""
      @project_idea.update(content: params[:content])
      redirect "/project_ideas/#{@project_idea.id}"
    else
      redirect "users/#{current_user.id}"
    end
  end

  delete '/project_ideas/:id' do
    set_project_idea
    if authorized_to_edit?(@project_idea)
      @project_idea.destroy
      flash[:message] = "Successfully deleted project idea."
      redirect '/project_ideas'
    else
      redirect '/project_ideas'
    end
  end

  post '/project_ideas/status' do
    redirect_if_not_logged_in
    @project = set_project_idea
    @project.status = !@project.status
    redirect "/users/#{current_user.id}"
  end

  private

  def set_project_idea
    @project_idea = ProjectIdea.find(params[:id])
  end

end
