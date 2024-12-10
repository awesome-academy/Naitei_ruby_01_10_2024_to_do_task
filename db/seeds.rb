User.create!(
  email: 'admin@example.com',
  password: 'password123',
  name: 'Admin User',
  role: 1
)

User.create!(
  email: 'user@example.com',
  password: 'password123',
  name: 'Regular User',
  role: 0
)
