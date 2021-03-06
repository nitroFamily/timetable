require 'spec_helper'

describe "Group" do
	before do
		@group = Group.new(name: "Exampl", email: "user@example.com",
											 password: "foobar", password_confirmation: "foobar")
	end

	subject {@group}

	it {should respond_to(:name)}
	it {should respond_to(:email)}
	it {should respond_to(:password_digest)}
	it {should respond_to(:password)}
	it {should respond_to(:password_confirmation)}
	it {should respond_to(:remember_token)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:admin)}
  it {should respond_to(:lessons)}

  it {should be_valid}
  it {should_not be_admin}	


  describe "with admin attribute set to 'true'" do
    before do
      @group.save!
      @group.toggle!(:admin)
    end

    it {should be_admin}
  end

	describe "When name is not present" do
		before {@group.name = " "}
		it {should_not be_valid}
	end

	describe "When email is not present" do
		before {@group.email = " "}
		it {should_not be_valid}
	end

	describe "When name is too long" do
		before {@group.name = "a" * 55}
		it {should_not be_valid}
	end

	describe "When email is too long" do
		before {@group.email = "a" * 55}
		it {should_not be_valid}
	end

	describe "When name is too short" do
		before {@group.name = "a"}
		it {should_not be_valid}
	end

	describe "When email is too short" do
		before {@group.email = "a"}
		it {should_not be_valid}
	end

	describe "When email format is invalid" do
		it "should de invalid" do 
			emails = %w[user@foo,com 
									user_at_foo.org 
									example.user@foo. 
									foo@bar_baz.com 
									foo@bar+baz.com]

			emails.each do |email|
				@group.email = email
				expect(@group).not_to be_valid
			end
		end
	end

	describe "When email format is valid" do
		it "should be invalid" do 
			emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]

			emails.each do |email|
				@group.email = email
				expect(@group).to be_valid
			end
		end
	end

	describe "When email address is already taken" do
		before do
			group_with_same_email = @group.dup
			group_with_same_email.email.upcase!
			group_with_same_email.save
		end

		it {should_not be_valid}
	end

	describe "When password is not present" do
		before {@group.password = @group.password_confirmation = " "}
		it {should_not be_valid}
	end

	describe "When password is not present" do
		before {@group.password_confirmation = "mismatch"}
		it {should_not be_valid}
	end

	describe "with a password that's too short" do
	  before { @group.password = @group.password_confirmation = "a" * 5 }
	  it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before {@group.save}
		let(:found_group) {Group.find_by(email: @group.email)}

		describe "with valid password" do
			it {should eq found_group.authenticate(@group.password)}
		end

		describe "with invalid password" do
			let(:group_for_invalid_password) {found_group.authenticate("invalid")}

			it {should_not eq group_for_invalid_password}
			it {expect(group_for_invalid_password).to be_false}
		end
	end

	describe "remember token" do
    before {@group.save}
    its(:remember_token) {should_not be_blank}
  end

  describe "lesson destroy" do

    before {@group.save}
    let!(:lesson1) do
      FactoryGirl.create(:lesson, group: @group, created_at: 1.day.ago)
    end
    let!(:lesson2) do
      FactoryGirl.create(:lesson, group: @group, created_at: 1.hour.ago)
    end

    it "should destroy associated lesson" do
      lesson = @group.lessons.to_a
      @group.destroy
      expect(lesson).not_to be_empty

      lesson.each do |lesson|
        expect(Lesson.where(id: lesson.id)).to be_empty
      end
    end
  end
end
