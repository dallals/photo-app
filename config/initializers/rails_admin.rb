RailsAdmin.config do |config|

  ### Popular gems integration

  config.authorize_with do
    redirect_to main_app.root_path unless current_user == User.find_by(email: 'sammydallal@gmail.com') 
  end

  RailsAdmin.config do |config|
  config.main_app_name = ["Photo App"]
  # or something more dynamic
  config.main_app_name = Proc.new { |controller| [ "Photo App", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }
  end

  Kaminari.configure do |config|
    config.page_method_name = :per_page_kaminari
  end

  config.model 'User' do
    list do
      configure :id do
        hide
      end
    end
  end

  # config.assets.initialize_on_precompile = false
  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
