module ApplicationHelper


  def active_page(active_page)
    @active == active_page ? "active" : ""
  end

	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
  devise_mapping.to
 end

  def page_header(text)
    content_for(:page_header) { text.to_s }
  end

  def gravatar_for(user, size = 90, title = user.name )
    image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded'
  end

  def gravatar_for_group(group, size = 90, title = group.group_name )
    image_tag gravatar_image_url(group.group_name, size: size), title: title, class: 'img-rounded'
  end

end
