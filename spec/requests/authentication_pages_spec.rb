require 'spec_helper'

describe "Authentication" do
	subject {page}

	describe "signin page" do
		before {visit signin_path}

		describe "with invalid information" do
			before { click_button "Войти" }

      it { should have_title('Вход') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Главная" }
        it { should_not have_selector('div.alert.alert-error') }
      end
		end

		describe "with valid information" do
			let(:group) {FactoryGirl.create(:group)}
			before do
				fill_in "Email",    with: user.email.upcase
        fill_in "Пароль",   with: user.password
        click_button "Войти"
			end
			it {should have_title(group.name)}
			it {should have_link('Профиль',   href: group_path(group))}
			it {should have_link('Выйти',     href: signout_path)}
			it {should_not have_link('Войти', href: signoin_path)}
		end
	end		
end