require 'spec_helper'

describe "Group pages" do

	subject {page}

	describe "Signup page" do
		before {visit signup_path}

		let(:submit) {"Create my account"}

		describe "with invalid information" do
			it "should not create a group" do
				expect {click_button submit}.not_to change(Group, :count)
			end				
		end

		describe "with valid information" do
			before do
				fill_in "Name",         with: "Example"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
			end

			it "should create group" do
				expect {click_button submit}.to change(Group, :count).by(1)
			end
		end
	end

	describe "Profile page" do
		let(:group)	{FactoryGirl.create(:group)}

		before {visit group_path(group)}

		it {should have_content(group.name)}
		it {should have_title(group.name)}
	end
end