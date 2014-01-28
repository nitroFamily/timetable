require 'spec_helper'

describe "Lesson" do
  let(:group) {FactoryGirl.create(:group)}
  before do
    @lesson = group.lessons.build(name: "Тест",
    										 form: 1,
    										 number: 3,
    										 classroom: "531/2",
    										 day: 4,
    										 start_week: 1,
    										 end_week: 18)
  end

  subject { @lesson }

  it {should respond_to(:name)}
  it {should respond_to(:form)}
  it {should respond_to(:number)}
  it {should respond_to(:classroom)}
  it {should respond_to(:day)}
  it {should respond_to(:start_week)}
  it {should respond_to(:end_week)}
  it {should respond_to(:group_id)}
  it {should respond_to(:group)}
  its(:group) {should eq group}

  describe "when hroup_id is not present" do
    before {@lesson.group_id = nil}
    it {should_not be_valid}
  end

  describe "when group_id is not present" do
    before {@lesson.group_id = nil}
    it {should_not be_valid}
  end

  describe "with blank name" do
    before {@lesson.name = " "}
    it {should_not be_valid}
  end

  describe "with name that is too long" do
    before {@lesson.name = "a" * 25}
    it {should_not be_valid}
  end

  describe "when form is not present" do
    before {@lesson.form = nil}
    it {should_not be_valid}
  end

  describe "with blank form" do
    before {@lesson.form = ""}
    it {should_not be_valid}
  end

  describe "with form greater than 3" do
    before {@lesson.form = 4}
    it {should_not be_valid}
  end

  describe "with form less than 1" do
    before {@lesson.form = 0}
    it {should_not be_valid}
  end

  describe "when number is not present" do
    before {@lesson.number = nil}
    it {should_not be_valid}
  end

  describe "with blank number" do
    before {@lesson.number = ""}
    it {should_not be_valid}
  end

  describe "with number greater than 5" do
    before {@lesson.number = 6}
    it {should_not be_valid}
  end

  describe "with number less than 1" do
    before {@lesson.number = 0}
    it {should_not be_valid}
  end

  describe "when classroom is not present" do
    before {@lesson.classroom = nil}
    it {should_not be_valid}
  end

  describe "with blank classroom" do
    before {@lesson.classroom = " "}
    it {should_not be_valid}
  end

  describe "when classroom format is invalid" do
    before {@lesson.classroom = "522"}
    it {should_not be_valid}
  end

  describe "when classroom format is valid" do
    before {@lesson.classroom = "522/2/1"}
    it {should be_valid}
  end

  describe "when day is not present" do
    before {@lesson.day = nil}
    it {should_not be_valid}
  end

  describe "with blank day" do
    before {@lesson.day = ""}
    it {should_not be_valid}
  end

  describe "with day greater than 7" do
    before {@lesson.day = 8}
    it {should_not be_valid}
  end

  describe "with day less than 1" do
    before {@lesson.day = 0}
    it {should_not be_valid}
  end
end
