module GroupsHelper
	def what_week?
    point_week = 4
    current_week = Time.now.strftime("%W").to_i
    current_week - point_week
  end

  def get_lessons(week)
  	lessons = []

  	week = what_week? if week.nil?
  	periodicity = week.to_i%2 + 1

	  (0..5).each do |i|
      lessons[i] = @group.lessons.where("day = ? AND 
                                         start_week <= ? AND
                                         end_week >= ? AND( 
                                         periodicity = ? OR
                                         periodicity = 3)", i+1, week, week, periodicity)
		end
		lessons
  end



end
