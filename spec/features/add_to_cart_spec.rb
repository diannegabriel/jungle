require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    @user = User.create!( 
      first_name: "Santa",
      last_name: "Claws",
      email: "christmas@holiday.com",
      password: "n0rthpoLe",
      password_confirmation: "n0rthpoLe"
    )
    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "My Cart (0) should update to 1 when a product is added" do
    # ACT
    visit root_path
    visit "/login"
    fill_in('email', :with => "christmas@holiday.com")
    fill_in("password", :with => "n0rthpoLe")
    click_button "Submit"


    first('button.btn').click

    # DEBUG / VERIFY
    sleep 5
    save_screenshot

    expect(page).to have_content 'My Cart (1)'
  end

end