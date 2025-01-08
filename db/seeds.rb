# Create Users
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  name: 'Admin User',
  role: 'supervisor'
)

user = User.create!(
  email: 'user@example.com',
  password: 'password123',
  name: 'Regular User',
  role: 'mentor'
)

# Create Categories
categories = [
  Category.create!(name: 'Development', user_id: admin.id),
  Category.create!(name: 'Design', user_id: user.id),
  Category.create!(name: 'Management', user_id: admin.id)
]

# Create Tasks
tasks = []
10.times do |i|
  task = Task.create!(
    title: "Task #{i + 1}",
    description: "This is a detailed description for Task #{i + 1}.",
    priority: %w[low medium high urgent].sample,
    category: categories.sample,
    parent_task_id: i.even? ? nil : tasks.sample&.id,
    deadline: rand(5..15).days.from_now,
    start_date: rand(1..5).days.ago,
    status: %w[pending in_progress completed expired].sample,
    created_at: Time.now,
    updated_at: Time.now
  )

  tasks << task
end

puts "Seed data created successfully!\n"
