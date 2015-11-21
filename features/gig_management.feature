Feature: Gig Management
  The gig schedule that gets displayed in the app comes from a database.
  An admin user has the ability to create, update and delete gig dates.
  A gig entry is not displayed unless its published field is true.

  * An admin user can create gig entries
  * An admin user can delete gig entries
  * An admin user can edit gig entries
  - An admin user can change the publish state of a gig (add to "can edit gig entries"
  * A user who is not signed in cannot access any gig management features
  * A non-admin user cannot access any gig management features
  - Only published gigs appear on the schedule pages
  - Both published and unpublished gigs appear on the Gig Management page

  @javascript
  Scenario: An admin user can create gig entries
    Given I am signed in as an admin user
    When I navigate to the Manage Gigs page
    And I click Add Gig
    Then I see the Add Gig page
    When I fill in the gig fields
    And I click Add Gig
    Then the gig is created
    And I see information for the gig on the home page
    And I see information for the gig on the schedule page

  @javascript
  Scenario: An admin user can delete gig entries
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Manage Gigs page
    Then I see information for a gig
    When I click Delete and confirm deletion for that gig
    Then that gig is deleted
    And I am on the Manage Gigs page

  @javascript
  Scenario: An admin user can edit gig entries
    Given I am signed in as an admin user
    And there is at least one published gig
    When I navigate to the Manage Gigs page
    And I click Edit for the first gig
    Then I am sent to the Change Gig page
    When I change the gig fields
    And I click Update
    Then the gig fields are changed
    When I click Manage Gigs
    Then I am on the Manage Gigs page

  # @javascript
  # Scenario: An admin user can change the publish state of a gig

  @javascript
  Scenario: A user who is not signed in cannot access any of the gig management features
    Given I am not signed in
    When I look at the Navigation Menu
    And I do not see a Manage Gigs Link

    When I navigate to the Performance Schedule page
    Then I do not see an Edit button
    And I do not see a Delete button

    When I visit the Gig Management page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Add Gig page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

    When I visit the Edit Gig page directly
    Then I am sent to the Sign In page
    And I see an alert containing "You must be signed in to access that page"

  @javascript
  Scenario: A non-admin user cannot access any gig management features
    Given I am signed in as a non-admin user
    When I look at the Navigation Menu
    And I do not see a Manage Gigs Link

    When I visit the Gig Management page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

    When I visit the Add Gig page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

    When I visit the Edit Gig page directly
    Then I am sent to the Home page
    And I see an alert containing "You must be an admin user to access that page"

  # @javascript
  # Scenario: Only published gigs appear on the schedule pages

  # @javascript
  # Scenario: Both published and unpublished gigs appear on the Gig Management page

  # @javascript
  # Scenario: Tokens are properly interpolated into schedule lists
    #     verify that @info gets interpolated
    #     verify that [text](link) gets interpolated
    #     verify that when [name] == [Picture] and Note is a url, then the picture is inserted into the schedule.
