# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
EventAttendee.destroy_all
Event.destroy_all
User.destroy_all

# Create Users
users = []
usernames = ["CyberRacc", "MusicMaestro", "AnimArtist", "TechGuru", "CodeNinja"]
emails = ["cyberracc@example.com", "musicmaestro@example.com", "animartist@example.com", "techguru@example.com", "codeninja@example.com"]

5.times do |i|
  users << User.create!(
    username: usernames[i],
    email: emails[i],
    password: "123456",
    password_confirmation: "123456"
  )
end

puts "Created #{User.count} users"

# Create Events
events = []
event_names = [
  "Future Tech Expo", "Music Fest 2025", "Animation Conference",
  "Cyber Security Summit", "Ruby on Rails Workshop", "AI & ML Meetup",
  "Blockchain Symposium", "Creative Coding Hackathon", "Digital Art Exhibition",
  "VR & AR Expo"
]
event_descriptions = [
  "An expo showcasing the latest advancements in technology.",
  "A festival celebrating music from around the world.",
  "A conference for animators to share their work and learn new techniques.",
  "A summit focused on the latest in cyber security.",
  "A hands-on workshop for learning Ruby on Rails.",
  "A meetup for enthusiasts of artificial intelligence and machine learning.",
  "A symposium discussing the future of blockchain technology.",
  "A hackathon for creative coders to build innovative projects.",
  "An exhibition of digital art from various artists.",
  "An expo exploring the latest in virtual and augmented reality."
]
event_dates = [
  Time.new(2025, 6, 1, 9, 0), Time.new(2025, 7, 15, 12, 0),
  Time.new(2025, 8, 20, 10, 0), Time.new(2025, 9, 5, 14, 0),
  Time.new(2025, 10, 10, 11, 0), Time.new(2025, 11, 25, 16, 0),
  Time.new(2025, 12, 30, 13, 0), Time.new(2026, 1, 15, 9, 0),
  Time.new(2026, 2, 28, 10, 0), Time.new(2026, 3, 20, 14, 0)
]

10.times do |i|
  events << Event.create!(
    title: event_names[i],
    description: event_descriptions[i],
    location: "Location #{i + 1}",
    start_time: event_dates[i],
    end_time: event_dates[i] + 3.hours,
    user: users.sample
  )
end

puts "Created #{Event.count} events"

# Create Event Attendees
events.each do |event|
  attendees = users.sample(3) # Select 3 random users to attend the event
  attendees.each do |attendee|
    EventAttendee.create!(
      event: event,
      user: attendee,
      checked_in: [true, false].sample
    )
  end
end

puts "Created #{EventAttendee.count} event attendees"
