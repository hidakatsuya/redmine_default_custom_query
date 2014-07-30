class CreateProjectsDefaultQueries < ActiveRecord::Migration
  def change
    create_table :projects_default_queries do |t|
      t.belongs_to :project
      t.belongs_to :query

      t.timestamps
    end
    add_index :projects_default_queries, :project_id
    add_index :projects_default_queries, :query_id
  end
end
