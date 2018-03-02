def sign_in(user=nil)
  user ||= Fabricate(:user)
  visit login_path

  fill_in 'Username', with: user.username
  fill_in 'Password', with: user.password
  within("form[action='#{login_path}']") do
    click_button 'Login'
  end
end
