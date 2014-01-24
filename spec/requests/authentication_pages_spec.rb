require 'spec_helper'

describe "Authentication" do
	subject {page}
	let(:group) {FactoryGirl.create(:group)}

	describe "signin page" do
		before {visit signin_path}

		describe "with invalid information" do
			before do
				fill_in "Email",    with: group.email.upcase
        fill_in "Пароль",   with: "group.password"
				click_button "Войти" 
			end

      it { should have_title('Вход') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Главная" }
        it { should_not have_selector('div.alert.alert-error') }
      end
		end

		describe "with valid information" do
			before do
				fill_in "Email",    with: group.email.upcase
        fill_in "Пароль",   with: group.password
        click_button "Войти"
			end
			it {should have_title(group.name)}
			it {should have_link('Профиль',   href: group_path(group))}
			it {should have_link('Группы',    href: groups_path)}
			it {should have_link('Настройки', href: edit_group_path(group))}
			it {should have_link('Выйти',     href: signout_path)}
			it {should_not have_link('Войти', href: signin_path)}

			describe "followed by signout" do
        before {click_link "Выйти"}
        it {should have_link('Войти')}
      end
		end

		describe "authorization" do

			describe "for non-signed-in group" do
      let(:group) { FactoryGirl.create(:group) }

	      describe "when attempting to visit a protected page" do
	        before do
	          visit edit_group_path(group)
	          fill_in "Email",    with: group.email
	          fill_in "Пароль", 	with: group.password
	          click_button "Войти"
	        end

	        describe "after signing in" do

	          it "should render the desired protected page" do
	            expect(page).to have_title('Редактирование профиля')
	          end
	        end
	      end
      end

	    describe "for non-signed-in users" do
	      let(:group) { FactoryGirl.create(:group) }

	      describe "in the groups controller" do

	        describe "visiting the edit page" do
	          before { visit edit_group_path(group) }
	          it { should have_title('Вход') }
	        end

	        describe "submitting to the update action" do
	          before { patch group_path(group) }
	          specify { expect(response).to redirect_to(signin_path) }
	        end
	      end
	    end

	    describe "as wrong user" do
		    let(:group) { FactoryGirl.create(:group) }
		    let(:wrong_group) { FactoryGirl.create(:group, email: "wrong@example.com") }
		    before { sign_in group, no_capybara: true }

		    describe "submitting a GET request to the Group#edit action" do
		      before { get edit_group_path(wrong_group) }
		      specify { expect(response.body).not_to match(full_title('Редактирование профиля')) }
		      specify { expect(response).to redirect_to(root_url) }
		    end

		    describe "submitting a PATCH request to the Group#update action" do
		      before { patch group_path(wrong_group) }
		      specify { expect(response).to redirect_to(root_url) }
		    end
		  end

		  describe "as non-admin group" do
	      let(:group) { FactoryGirl.create(:group) }
	      let(:non_admin) { FactoryGirl.create(:group) }

	      before { sign_in non_admin, no_capybara: true }

	      describe "submitting a DELETE request to the Groups#destroy action" do
	        before { delete group_path(group) }
	        specify { expect(response).to redirect_to(root_url) }
	      end
	    end
	  end
	end		
end