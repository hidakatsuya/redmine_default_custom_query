class DefaultCustomQuerySettingController < ApplicationController
  unloadable

  before_filter :find_project_by_project_id
  before_filter :authorize

  def update
    @default_query = ProjectsDefaultQuery.find_or_initialize_by_project_id(@project.id)
    @default_query.safe_attributes = params[:settings]

    if @default_query.save
      redirect_to settings_project_path(@project, tab: 'default_custom_query'),
                  notice: l(:notice_successful_update)
    else
      render 'edit'
    end
  end

  def edit
  end
end
