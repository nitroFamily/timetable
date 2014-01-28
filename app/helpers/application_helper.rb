module ApplicationHelper
	def full_title(page_title)
		base_title = "Timetable"
		if page_title.empty? 
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def what_week?(time)
		point_week = 4
  	current_week = time.strftime("%W").to_i
  	current_week - point_week
  end
end
