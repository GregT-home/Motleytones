class Spinach::Features::GigManagement < Spinach::FeatureSteps
  include Helpers

  step 'I am not signed in' do
    visit root_path
  end

  step 'I am signed in as a non-admin user' do
    sign_in_non_admin_user
  end

  step 'I am signed in as an admin user' do
    sign_in_admin_user
  end

  step 'I look at the Navigation menu' do
    find("li.navigation").hover
  end

  step 'I navigate to the Manage Gigs page' do
    find("li.navigation").hover
    click_link "Manage Gigs"
    i_am_on_the_manage_gigs_page
  end

  step 'I am on the Manage Gigs page' do
    sync_page
    expect(page.title).to eq("Manage Gigs")
  end

  step 'I see the Add Gig page' do
    sync_page
    expect(page.title).to eq("Add Gig")
  end

  step 'I fill in the gig fields' do
    @gig = FactoryGirl.build(:gig)
    set_date("gig_date",       @gig.date.to_s)
    fill_in "gig_name",     with: @gig.name
    fill_in "gig_note",     with: @gig.note
    fill_in "gig_location", with: @gig.location
    check "gig_published"
  end

  step 'I click Add Gig' do
    click_link_or_button "Add gig"
    sync_page
  end

  step 'I click Manage Gigs' do
    click_link "Manage gigs"
  end

  step 'the gig is created' do
    @gig = Gig.find_by(name: @gig.name)
    expect(@gig).not_to be_nil
  end

  step 'I see information for a gig' do
    @gig = Gig.where(name: @gig.name).where(location: @gig.location).first
    verify_gig_schedule(@gig)
  end

  step 'I see information for the gig on the home page' do
    i_see_information_for_a_gig
    verify_gig_published(@gig)
  end

  step 'I see information for the gig on the schedule page' do
    visit "/schedule"
    verify_gig_schedule(@gig)
  end

  step 'there is at least one published gig' do
    begin
      @gig = FactoryGirl.create(:gig, published: true)
    rescue
      @gig = FactoryGirl.create(:gig, published: true)
    end
  end

  step 'I navigate to the Performance Schedule page' do
    find("li.navigation").hover
    click_link "Performance Schedule"
    expect(page.title).to eq("Motley Performance Schedule")
  end

  step 'I click Delete and confirm deletion for that gig' do
      my_accept_alert do
        find(".gig-id-#{@gig.id}").click_link("Delete")
      end
    sync_page
  end

  step 'that gig is deleted' do
    expect(Gig.find_by(id: @gig.id)).to be_nil
  end

  step 'I click Edit for the first gig' do
    find(".gig-id-#{@gig.id}").click_link("Edit")
  end

  step 'I am sent to the Change Gig page' do
    expect(page.title).to eq("Modify Gig Info")
  end

  step 'I am sent to the Sign In page' do
    expect(page.title).to eq("Sign In")
  end

  step 'I am sent to the Home page' do
    expect(page.title).to eq("The Motley Tones")
  end

  step 'I change the gig fields' do
    @changed_date = "9-Aug-2015"
    fill_in  "gig_name",     with: change(@gig.name)
    fill_in  "gig_note",     with: change(@gig.note)
    set_date "gig_date",     @changed_date
    fill_in  "gig_location", with: change(@gig.location)
  end

  step 'I click Update' do
    click_on "Update"
    sync_page
  end

  step 'the gig fields are changed' do
    within find("li.gig-id-#{@gig.id}") do
      expect(find(".gig_name").text).to     match("#{change(@gig.name)}")
      expect(find(".gig_note").text).to     match("#{change(@gig.note)},") # added "," text in page
      expect(find(".gig_date").text).to     match(Date.parse(@changed_date).strftime('%b %d:'))
      expect(find(".gig_location").text).to match("#{change(@gig.location)}")
    end
  end

  step 'there is at least one unpublished gig' do
    @unpublished_gig = FactoryGirl.create(:gig, published: false)
  end

  step 'I go to the Schedule Page' do
    visit schedule_path
  end

  step 'I see the published gig' do
    i_see_information_for_a_gig
  end

  step 'I go to the Schedule Page' do
    visit schedule_path
  end

  step 'I do not see a Manage Gigs link' do
    expect(page).to have_no_link("Manage Gigs")
  end

  step 'I do not see the unpublished gig' do
    expect(find(".gig-id-#{@unpublished_gig.id}")).not_to have_content(@unpublished_gig.name)
  end

  step 'I do not see an Add Gig link' do
    expect(page).to have_no_link("Add Gig")
  end

  step 'I do not see an Edit button' do
    expect(page).not_to have_button("Edit")
  end

  step 'I do not see a Delete button' do
    expect(page).not_to have_button("Delete")
  end

  step 'I navigate to the Sign In page' do
    find("li.navigation").hover
    i_click_sign_in
    expect(page.title).to eq("Sign In")
  end

  step 'I see an alert containing "You must be signed in to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be signed in to access that page")
  end

  step 'I see an alert containing "You must be an admin user to access that page"' do
    has_flash_msg(severity: :alert, containing: "You must be an admin user to access that page")
  end

  step 'I visit the Gig Management page directly' do
    visit manage_gigs_path
  end

  step 'I visit the Add Gig page directly' do
    visit new_gig_path
  end

  step 'I visit the Edit Gig page directly' do
    visit edit_gig_path(1) # any user id will work for this test
  end

  step 'I change the published checkbox' do
    if @gig.published?
      @orig_published_value = true
      uncheck "gig_published"
    else
      @orig_admin_value = false
      check "gig_published"
    end
  end

  step 'the published field is changed' do
    within find("h3.gig-id-#{@gig.id}") do
      if @orig_published_value
        expect(page).not_to have_css("p.user_published")
      else
        expect(page).to have_css("p.user_published")
      end
    end
  end

  private

  def verify_gig_schedule(gig)
    id_class = ".gig-id-#{gig.id}"
    expect(find("#{id_class} .gig_name")).to have_content(@gig.name)
    expect(find("#{id_class} .gig_note")).to have_content(@gig.note)
    expect(find("#{id_class} .gig_location")).to have_content(@gig.location)
  end

  def verify_gig_published(gig)
    expect(find(".gig-id-#{gig.id}.gig_published").text).to have_content(@gig.published)
  end
end
