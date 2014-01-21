require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) {"Timetable"}
    let(:page_title) {"Главная"}
    
    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) {"Help"}
    let(:page_title) {"Помощь"}
    
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) {"About"}
    let(:page_title) {"О нас"}
    
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) {"Contact"}
    let(:page_title) {"Контакты"}
    
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "О нас"
    expect(page).to have_title(full_title("О нас"))
    click_link "Помощь"
    expect(page).to have_title(full_title("Помощь"))
    click_link "Контакты"
    expect(page).to have_title(full_title("Контакты"))
    click_link "Главная"
    click_link "Создать расписание!"
    expect(page).to have_title(full_title("Sign up"))
  end
end