stopifnot(exists("casual_ride_data"))
stopifnot(exists("member_ride_data"))

# TODO: Readability
avg_per_weekday = c(
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Sunday"   ),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Sunday"   ),]$ride_length) / 60.0,
  
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Monday"   ),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Monday"   ),]$ride_length) / 60.0,
  
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Tuesday"  ),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Tuesday"  ),]$ride_length) / 60.0,
  
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Wednesday"),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Wednesday"),]$ride_length) / 60.0,
  
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Thursday" ),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Thursday" ),]$ride_length) / 60.0,
  
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Friday"   ),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Friday"   ),]$ride_length) / 60.0,
  
  mean(casual_ride_data[which(casual_ride_data$day_of_trip == "Saturday" ),]$ride_length) / 60.0,
  mean(member_ride_data[which(member_ride_data$day_of_trip == "Saturday" ),]$ride_length) / 60.0
)

# Create a bar graph to compare average ride times between casual riders and members

weekday = c(rep("Sunday", 2), rep("Monday", 2), rep("Tueday", 2), rep("Wednesday", 2), rep("Thursday", 2), rep("Friday", 2), rep("Saturday", 2))
membership = rep(c("Casual", "Member"), 7)
plot_df = data.frame(weekday, membership, avg_per_weekday)

ggplot(plot_df, aes(x = weekday, y = avg_per_weekday, fill = membership)) + 
  geom_col(position = "dodge") +
  scale_x_discrete(limits = unique(weekday)) +
  #ggtitle("Average Ride Length per Weekday") +
  labs(x = "Weekday", y = "Avg. Time in Minutes", fill = "Membership") +
  scale_fill_manual("Legend", values = c("Casual" = "#eb3b3b", "Member" = "#0d9ee0"))

rm(avg_per_weekday)

# Get the average ride duration in minutes per month
avg_per_month = c()
for (x in 1:12) {
  monthly_avg = mean(casual_ride_data[which(as.integer(format(casual_ride_data$started_at, format = "%m")) == x),]$ride_length) / 60.0
  avg_per_month = append(avg_per_month, monthly_avg)
  
  monthly_avg = mean(member_ride_data[which(as.integer(format(member_ride_data$started_at, format = "%m")) == x),]$ride_length) / 60.0
  avg_per_month = append(avg_per_month, monthly_avg)
}

months = rep(1:12, each=2)
months_chr = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
membership = rep(c("Casual", "Member"), 12)
plot_df = data.frame(months, membership, avg_per_month)

ggplot(plot_df, aes(x = months, y = avg_per_month, fill = membership)) + 
  geom_line(aes(color = membership), position = "dodge", size = 1) +
  scale_x_discrete(limits = unique(months), labels = months_chr) +
  #ggtitle("Average Ride Length per Month") +
  labs(x = "Month", y = "Avg. Time in Minutes", fill = "Membership") +
  scale_fill_manual("Legend", values = c("Casual" = "#eb3b3b", "Member" = "#0d9ee0"))

# Get average times per hour
avg_per_hour = c()
for (x in 0:23) {
  hourly_avg = mean(casual_ride_data[which(as.integer(format(casual_ride_data$started_at, format = "%H")) == x),]$ride_length) / 60.0
  avg_per_hour = append(avg_per_hour, hourly_avg)
  
  hourly_avg = mean(member_ride_data[which(as.integer(format(member_ride_data$started_at, format = "%H")) == x),]$ride_length) / 60.0
  avg_per_hour = append(avg_per_hour, hourly_avg)
}

hours = rep(1:24, each = 2)
hours_chr = c()
for (x in 1:12) {
  hours_chr = append(hours_chr, paste(as.character((x * 2) - 1), "00", sep = ":"))
  hours_chr = append(hours_chr, "")
}
membership = rep(c("Casual", "Member"), 12)
plot_df = data.frame(hours, membership, avg_per_hour)

ggplot(plot_df, aes(x = hours, y = avg_per_hour)) + 
  geom_line(aes(color = membership), size = 2) +
  scale_x_discrete(limits = unique(hours), labels = hours_chr) +
  geom_point() +
  labs(x = "Hour", y = "Avg. Time in Minutes", fill = "Membership") +
  scale_fill_manual("Legend", values = c("Casual" = "#eb3b3b", "Member" = "#0d9ee0"))