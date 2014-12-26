Redmine::Plugin.register :redmine_tablemanager do
  name 'Redmine Tablemanager plugin'
  author 'Birdworks'
  description 'This is a plugin for Redmine'
  version '0.0.2'
  #url 'http://example.com/path/to/plugin'
  #author_url 'http://example.com/about'

  project_module :redmine_tablemanager do
    permission :tm_tables, { :tm_tables => [:index] }, :public => true
    menu :project_menu, :redmine_tablemanager, { :controller => 'tm_tables', :action => 'index'}, :param => :project_id
  end

end
