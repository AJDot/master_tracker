feature 'user create entry from stopwatch', js: true do
  given(:alice) { Fabricate(:user) }

  scenario 'with valid inputs' do
    category = Fabricate(:category, user: alice)
    skill = Fabricate(:skill, user: alice)
    description = Fabricate(:description, user: alice)
    sign_in(alice)
    click_link 'New'
    click_link 'Stopwatches'
    page.find('.startstop', text: 'Start').click
    select category.name, from: "Category"
    select skill.name, from: "Skill"
    select description.name, from: "Description"
    sleep(30)
    click_button "Submit"
    expect(page).to have_content "successfully"

  end

  scenario 'with invalid inputs' do
    category = Fabricate(:category, user: alice)
    skill = Fabricate(:skill, user: alice)
    description = Fabricate(:description, user: alice)
    sign_in(alice)
    click_link 'New'
    click_link 'Stopwatches'

    select category.name, from: "Category"
    select skill.name, from: "Skill"
    select description.name, from: "Description"
    click_button "Submit"
    # duration on stopwawtch is still zero which is not allowed
    expect(page).to have_content "There was an error saving the entry. Sorry! Did your stopwatch have less than a minute on it?"
  end
end
