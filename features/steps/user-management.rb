class Spinach::Features::UserManagement < Spinach::FeatureSteps
  include Helpers

  step 'I am not signed in' do
    visit root_path
  end

  step "I am signed in as a non-admin user" do
    sign_in_non_admin_user
  end

  step "I am signed in as an admin user" do
    sign_in_admin_user
  end

  step 'I look at the Navigation menu' do
    find("li.navigation").hover
  end

  # admin
  step 'I navigate to the Add Pirate page' do
    find("li.navigation").hover
    click_link "Add Pirate"
    sync_page
    expect(page.title).to eq("Add New Pirate")
  end

  step 'I navigate to the Users page' do
    find("li.navigation").hover
    click_link "List Pirates"
    sync_page
    expect(page.title).to eq("Motley Users")
  end

  step 'I navigate to the Sign In page' do
    find("li.navigation").hover
    i_click_sign_in
    expect(page.title).to eq("Sign In")
  end

  step 'I navigate to the Profile page' do
    find("li.navigation").hover
    click_link "Profile"
    sync_page
    expect(page.title).to eq("Motley User")
  end

  # admin
  step 'I visit the Add Pirate page directly' do
    visit new_user_path
  end

  step 'I visit the Users page directly' do
    visit users_path
  end

  step 'I visit the Edit Profile page directly' do
    visit edit_user_path(1)  # any user id will work for this test
  end

  step 'I do not see a List Users link' do
    expect(page).to have_no_link("List Users")
  end

  step 'I do not see an Add Pirate link' do
    expect(page).to have_no_link("Add Pirate")
  end

  step 'I do not see a Profile link' do
    expect(page).to have_no_link("Profile")
  end

  step 'I do not see a Sign Out link' do
    expect(page).to have_no_link("Sign Out")
  end

  step 'I do not see a Delete button' do
    expect(page).to have_no_button("Delete")
  end

  step 'I am sent to the Change User Information page' do
    expect(page.title).to eq("Modify Pirate Profile")
  end

  step 'I am sent to the Profile page' do
    expect(page.title).to eq("Motley User")
    expect(page.text).to match(Regexp.new(".*#{@user.name}.*"))
  end

  step 'I am sent to the Sign In page' do
    expect(page.title).to eq("Sign In")
  end

  step 'I see a success message containing "Signed in successfully"' do
    has_flash_msg(severity: :notice, containing: "Signed in successfully")
  end

  step 'I see an alert containing "You must be signed in to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be signed in to access that page")
  end

  step 'I see an alert containing "You must be an admin user to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be an admin user to access that page")
  end

  step 'I see an alert containing "Invalid email or password"' do
    has_flash_msg(severity: :alert, containing: "Invalid email or password")
  end

  step 'I see the new user name' do
    expect(page).to have_content(@user.name)
  end

  step 'I click Edit' do
    # need test to see that the page is for the right user
    click_on "Edit Info"
    sync_page
  end

  step 'I click Edit for that other user' do
    find(".user-id-#{@another_user.id} form.button_to .edit").click
    sync_page
  end

  step 'I click Delete and confirm deletion for that other user' do
    my_accept_alert do
      find(".user-id-#{@another_user.id} form.button_to .delete").click
    end
    sync_page
  end

  step 'that other user is deleted' do
    user = User.find_by(email: @another_user.email)
    expect(user).to be_nil
  end

  step 'there is at least one other user' do
    @another_user = FactoryGirl.create(:user)
  end

  step 'I see information for another user' do
    expect(page.text).to have_content(@another_user.name)
  end

  step 'I fill in the fields' do
    @start_date = "9-Jul-2010"
    @another_user = FactoryGirl.build(:user)
    fill_in "user_name", with: @another_user.name
    fill_in "user_tone_name", with: @another_user.tone_name
    select_date(@start_date)
    fill_in "user_email", with: @another_user.email
    fill_in "user_password", with: PASSWORD
    fill_in "user_password_confirmation", with: PASSWORD
    check "user_admin"
  end

  step 'I click Sign Up' do
    click_link_or_button "Sign up"
    sync_page
  end

  step 'the account is created' do
    user = User.find_by(email: @another_user.email)
    expect(user).not_to be_nil
  end

  step 'I change the mutable fields' do
    change_mutable_fields(@user)
  end

  step 'I change the mutable fields for that other user' do
    change_mutable_fields(@another_user)
  end

  step 'I change the admin checkbox' do
    if @user.admin?
      @old_admin_value = true
      uncheck "user_admin"
    else
      @old_admin_value = false
      check "user_admin"
    end
  end

  step 'I click Update' do
    click_on "Update"
    sync_page
  end

  step 'the mutable fields are not changed' do
    expect(find(".user_name")).to have_content(@user.name)
    expect(find(".user_tone_name")).to have_content(@user.tone_name)
    expect(find(".user_email")).to have_content(@user.email)
    expect(find(".user_start_date")).to have_content(@start_date)
  end

  step 'the mutable fields are changed' do
    expect_mutable_fields_to_be_changed(@user)
  end

  step 'the mutable fields for that other user are changed' do
    expect_mutable_fields_to_be_changed(@another_user)
  end

  step 'the admin field is not changed' do
    if @old_admin_value
      expect(page).to have_css("p.user_admin")
    else
      expect(page).not_to have_css("p.user_admin")
    end
  end

  step 'the admin field is changed' do
    id_class = ".user-id-#{@another_user.id}"
    if @old_admin_value
      expect(page).not_to have_css("p#{id_class}.user_admin")
    else
      expect(page).to have_css("p#{id_class}.user_admin")
    end
  end

  step 'I click Cancel' do
    click_on "Cancel"
    sync_page
  end

  step 'I click Sign In' do
    click_on "Sign in"
    sync_page
  end

  step 'I am still in the admin account' do
    find("li.navigation").hover
    expect(find("li.informational")).to have_content(@user.tone_name)
  end

  step 'I enter a registered email' do
    @user = FactoryGirl.create(:user, password: PASSWORD)
    fill_in("user_email", with: @user.email)
  end

  step 'I enter the associated password' do
    fill_in("user_password", with: PASSWORD)
  end

  step 'I enter an unregistered email' do
    fill_in("user_email", with: "not_registered@user.com")
  end

  step 'I enter an invalid password' do
    fill_in("user_password", with: "incorrect-password")
  end

  private

  def change(item)
    item[0] + "changed" + item[1..-1]
  end

  def select_date(date)
    find("#user_band_start_date_1i").select(Date.parse(date).year)
    find("#user_band_start_date_2i").select(Date::MONTHNAMES[Date.parse(date).month])
    find("#user_band_start_date_3i").select(Date.parse(date).day)
  end

  def change_mutable_fields(user)
    @changed_date = "1-Apr-#{Date.today.year + 1}" # app always allows one year more than today
    fill_in "user_name",       with: change(user.name)
    fill_in "user_tone_name",  with: change(user.tone_name)
    fill_in "user_email",      with: change(user.email)
    select_date(@changed_date)
  end

  def expect_mutable_fields_to_be_changed(user)
    id_class = ".user-id-#{user.id}"
    expect(find("#{id_class} .user_name").text).to       match("#{change(user.name)}")
    expect(find("#{id_class} .user_tone_name").text).to  match("#{change(user.tone_name)}")
    expect(find("#{id_class} .user_email").text).to      match("#{change(user.email)}")
    expect(find("#{id_class} .user_start_date").text).to match(@changed_date)
  end
end
