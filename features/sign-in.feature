Feature: Sign-In
  Most users of the site do not need an account in order to make use of the site/app.  Band members and select others will need access to private features.

  * A user can sign into the app with registered email and password

  * A user who is not signed up cannot access any of the user management buttons on the Users page.
  * A  non-admin user cannot add a new user
  * A non-admin user can manage his own profile information, but cannot delete his account.

  @javascript
  Scenario: A user can sign into the system with registered email and password
    Given I am not signed in
    When I navigate to the Sign In page
    And I enter a registered email
    And I enter the associated password
    And I click Sign In
    Then I am sent to the Profile page
    And I see a success message containing "Signed in successfully"

  @javascript
  Scenario: A user cannot sign into the system with an unregistered email or password
    Given I am not signed in
    When I navigate to the Sign In page
    And I enter an unregistered email
    And I enter an invalid password
    And I click Sign In
    Then I see an alert containing "Invalid email or password"
    When I enter a registered email
    And I enter an invalid password
    And I click Sign In
    Then I see an alert containing "Invalid email or password"

  @chrome
  Scenario: A user who is not signed in cannot access any of the user management buttons
    Given I am not signed in
    When I look at the Navigation Menu
    Then I do not see a List Users link
    And I do not see a Profile link
    And I do not see a Sign Out link

    When I visit the Users page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You need to sign in or sign up before continuing"

    When I visit the Add Pirate page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You need to sign in or sign up before continuing"

    When I visit the Edit Profile page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You need to sign in or sign up before continuing"

  @javascript
  Scenario: A non-admin user cannot add a new user
    Given I am signed in as a non-admin user
    When I look at the Navigation Menu
    Then I do not see an Add User link

    When I visit the Add User page directly
    Then I am sent to the Profile page
    And I see an error containing "You must be an admin user to access that page"

  @javascript
  Scenario: A non-admin user cannot delete his own profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    And I do not see a Delete button

  @javascript
  Scenario: A non-admin user cannot change his admin status
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click Edit
    Then I am sent to the Change User Information page
    When I change the admin checkbox
    And I click Update
    And the admin field is not changed

  @javascript
  Scenario: A non-admin user can edit his own profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click Edit
    Then I am sent to the Change User Information page
    When I change the mutable fields
    And I click Update
    Then the mutable fields are changed

  @javascript @admin
  Scenario: A non-admin user can cancel the edit of his profile
    Given I am signed in as a non-admin user
    When I navigate to the Profile page
    When I click Edit
    Then I am sent to the Change User Information page
    When I change the mutable fields
    And I click Cancel
    Then the mutable fields are not changed

  @javascript @admin @test
  Scenario: Admin users can create a new user account
    Given I am signed in as an admin user
    When I navigate to the Add Pirate page
    And I fill in the fields
    And I click Sign up
    Then the account is created
    And I am still in the admin account

  @chrome @admin @test
  Scenario:  Admin users can delete a user account
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Users page
    Then I see information for another user
    When I click Delete for that other user
    Then I see an "Are you sure?" dialog box
    When I click Yes
    Then the user is deleted

  @chrome @admin @test
  Scenario:  Admin users can edit a user account from the Users Page
    Given I am signed in as an admin user
    And there is at least one other user
    When I navigate to the Users page
    And I click Edit for that other user
    Then I am sent to the Change User Information page
    When I change the mutable fields
    And I change the user_name field
    And I change the admin checkbox
    And I click Update
    Then the mutable fields are updated
    And the admin field is changed

  #@javascript @admin
  # Scenario:  Admin users can deactivate a user account
  #   Given I am signed in as an admin user
  #   And there is at least one other user
  #   When I navigate to the Users page
  #   And I see information for that other user
  #   And I click Deactivate for that other user
  #   Then the user is Deactivated
