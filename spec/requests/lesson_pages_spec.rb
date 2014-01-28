require 'spec_helper'

describe "Lesson pages" do

  subject { page }

  let(:group) { FactoryGirl.create(:group) }
  before { sign_in group }

  describe "lesson creation" do
    before { visit group_path(group) }

    describe "with invalid information" do

      it "should not create a lesson" do
        expect { click_button "Создать" }.not_to change(Lesson, :count)
      end

      describe "error messages" do
        before { click_button "Создать" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
      	fill_in 'Название предмета',with: "Тест"
      	fill_in 'Тип', 			        with: "1"
      	fill_in 'Пара', 		        with: "3"
      	fill_in 'Аудитория',        with: "552/1"
      	fill_in 'День', 				    with: "4"
      	fill_in 'Начальная неделя', with: "3"
      	fill_in 'Конечная неделя', 	with: "18"
      end
      it "should create a lesson" do
        expect { click_button "Создать" }.to change(Lesson, :count).by(1)
      end
    end
  end
end