module DefaultCustomQueryHelper
  def options_for_selectable_queries(project)
    options_groups = []

    queries = IssueQuery.only_public.where(project_id: nil)
    if queries.any?
      options_groups << [l('default_custom_query.label_queries_for_all_projects'), queries]
    end

    queries = project.queries.only_public
    if queries.any?
      options_groups << [l('default_custom_query.label_queries_for_current_project'), queries]
    end

    options_groups.map do |group, options|
      [group, options.collect {|o| [o.name, o.id] }]
    end
  end
end