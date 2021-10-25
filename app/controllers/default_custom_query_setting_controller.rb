class DefaultCustomQuerySettingController < ApplicationController

  before_action :find_project_by_project_id, only: :update
  before_action :authorize, only: :update
  before_action :require_admin, only: [:index, :global_update]
  
  def index
    @current_global_query = ProjectsDefaultQuery.get_global_query()
  end

  def global_update
    settings = params[:settings]

    @global_default_query = ProjectsDefaultQuery.get_global_query()
    @global_default_query.query_id = settings[:query_id]

    if @global_default_query.save
      session[:query] = nil
    else
      logger.info @global_default_query.errors.full_messages
    end
  end

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
