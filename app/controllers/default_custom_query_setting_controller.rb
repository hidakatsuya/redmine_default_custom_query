class DefaultCustomQuerySettingController < ApplicationController

  before_action :find_project_by_project_id
  before_action :authorize

  def update
    settings = params[:settings]

    @default_query = ProjectsDefaultQuery.initialize_for(@project.id)
    @default_query.query_id = settings[:query_id]

    if @default_query.save
      session[:query] = nil
    end

    render partial: 'form'
  end
end
