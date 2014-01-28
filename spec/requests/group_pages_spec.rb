require 'spec_helper'

describe "Group pages" do

	subject {page}

	describe "index" do
    before do
      sign_in FactoryGirl.create(:group)
      FactoryGirl.create(:group, name: "test1", email: "test1@example.com")
      FactoryGirl.create(:group, name: "test2", email: "test2@example.com")
      visit groups_path
    end

    it { should have_title('Группы') }
    it { should have_content('Группы') }

    it "should list each group" do
      Group.all.each do |group|
        expect(page).to have_selector('li', text: group.name)
      end
    end

    describe "pagination" do

      before(:all) { 45.times { FactoryGirl.create(:group) } }
      after(:all)  { Group.delete_all }

      it {should have_selector('div.pagination')}

      it "should list each group" do
        Group.paginate(page: 1).each do |group|
          expect(page).to have_selector('li', text: group.name)
        end
      end
    end
  end

	describe "Signup page" do
		before {visit signup_path}

		let(:submit) {"Создать"}

		describe "with invalid information" do
			it "should not create a group" do
				expect {click_button submit}.not_to change(Group, :count)
			end				
		end

		describe "with valid information" do
			before do
				fill_in "Название группы", with: "Example"
        fill_in "Email",           with: "user@example.com"
        fill_in "Пароль",          with: "foobar"
        fill_in "И снова пароль",  with: "foobar"
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

	describe "edit" do
  	# let(:group) { FactoryGirl.create(:group) }
  	# before {visit edit_group_path(group)}

  	# describe "page" do
  	# 	it {should have_content("Профиль")}
   #    it {should have_title("Редактирование профиля")}
  	# end

  	# describe "with invalid information" do
   #    before {click_button "Сохранить"}
   #    it {should have_content('error')}
   #  end

   #  describe "with valid information" do
   #    let(:new_name)  {"New Name"}
   #    let(:new_email) {"new@example.com"}
   #    before do
   #      fill_in "Название группы",       with: new_name
   #      fill_in "Email",          with: new_email
   #      fill_in "Пароль",         with: group.password
   #      fill_in "И снова пароль", with: group.password
   #      click_button "Сохранить"
   #    end

   #    it {should have_title(new_name)}
   #    it {should have_selector('div.alert.alert-success')}
   #    it {should have_link('Выйти', href: signout_path)}
   #    it {should_not have_link('Войти')}
   #    it {expect(group.reload.name).to  eq new_name}
   #    it {expect(group.reload.email).to eq new_email}
   #  end

   describe "delete links" do

      it {should_not have_link('delete')}

      describe "as an admin user" do
        let(:admin) {FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit groups_path
        end

        it {should have_link('delete', href: group_path(Group.first))}
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(Group, :count).by(-1)
        end
        it {should_not have_link('delete', href: group_path(admin))}
      end
    end

    describe "profile page" do
      let(:group) { FactoryGirl.create(:group) }
      let!(:l1) { FactoryGirl.create(:lesson, group: group, name: "Тест",
                                                            form: 1,
                                                            number: 3,
                                                            classroom: "531/2",
                                                            day: 4,
                                                            start_week: 1,
                                                            end_week: 18 )}
      let!(:l2) { FactoryGirl.create(:lesson, group: group, name: "Тест",
                                                            form: 1,
                                                            number: 3,
                                                            classroom: "531/2",
                                                            day: 4,
                                                            start_week: 1,
                                                            end_week: 18 )}

      before { visit group_path(group) }

      it { should have_content(group.name) }
      it { should have_title(group.name) }

      describe "lessons" do
        it { should have_content(l1.name) }
        it { should have_content(l2.name) }
        it { should have_content(group.lessons.count) }
      end
    end
  end
end