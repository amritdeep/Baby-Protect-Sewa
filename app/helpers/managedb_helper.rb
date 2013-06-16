module ManagedbHelper
	def ag3e(per)
  		now = Time.now.utc.to_date
  		(now.year - per.dob.year - (per.dob.to_date.change(:year => now.year) > now ? 1 : 0)).to_s + " year(s)"
	end

	def age(per)
	   dob = per.dob.to_date
	   unless dob.nil?
       a = Date.today.year - dob.year
       b = Date.new(Date.today.year, dob.month, dob.day)
       a = a-1 if b > Date.today
       return a
     end
     nil
	end
end
