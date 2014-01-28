class Lesson < ActiveRecord::Base
	belongs_to :group
	VALID_CLASSROOM_REGEX = /\A^\d{3}(\/\d{1}|\/\d{1}\/\d{1})$\z/i
  default_scope -> { order('day ASC, number ASC') }
	validates :group_id, presence: true
	validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :form, presence: true, numericality: { only_integer: true, 
  																								 greater_than_or_equal_to: 1,
  																								 less_than_or_equal_to: 3 }
  validates :number, presence: true, numericality: { only_integer: true, 
  																								 greater_than_or_equal_to: 1,
  																								 less_than_or_equal_to: 5 } 
  validates :classroom, presence: true, length: {minimum: 3, maximum: 10}, format: {with: VALID_CLASSROOM_REGEX}
  validates :day, presence: true, numericality: { only_integer: true, 
  																								 greater_than_or_equal_to: 1,
  																								 less_than_or_equal_to: 7 }
  validates :start_week, presence: true, numericality: { only_integer: true, 
  																								 greater_than_or_equal_to: 1,
  																								 less_than_or_equal_to: 18 }
  validates :end_week, presence: true, numericality: { only_integer: true, 
  																								 greater_than_or_equal_to: 1,
  																								 less_than_or_equal_to: 18 }
end
