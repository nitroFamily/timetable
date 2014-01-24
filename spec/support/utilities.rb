def full_title(page_title)
	base_title = "Timetable"
	if page_title.empty? 
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

def sign_in(group, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = Group.new_remember_token
    cookies[:remember_token] = remember_token
    group.update_attribute(:remember_token, Group.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: group.email
    fill_in "Пароль", with: group.password
    click_button "Войти"
  end
end