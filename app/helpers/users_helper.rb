module UsersHelper

  def update_provide_form_partial_path
    if current_user.provider == ""
    'devise/registrations/edit/no_provider_update_form'
    else
    'devise/registrations/edit/provider_update_form'
    end
  end
end
