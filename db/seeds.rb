# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(username: "alex", password: "alexx", password_confirmation: "alexx")
u2 = User.create(username: "jasmine", password: "jasmine", password_confirmation: "jasmine")

sp = Spreadsheet.create(user: u, name: "First Sheet")

c = Category.create(name: "Software Development", user: u)
c2 = Category.create(name: "Profession", user: u)
c3 = Category.create(name: "General", user: u)

s = Skill.create(name: "Ruby", user: u)
s2 = Skill.create(name: "Archaeology", user: u)
s3 = Skill.create(name: "JavaScript", user: u)

d = Description.create(name: "Mastery Tracker App", user: u)
d2 = Description.create(name: "Edit", user: u)
d3 = Description.create(name: "Exploration", user: u)

u.entries << Entry.new(category: c, skill: s, description: d, duration: 60, date: '2018-01-14')

u.entries << Entry.new(category: c2, skill: s2, description: d2, duration: 30, date: '2018-01-13')

u.entries << Entry.new(category: c3, skill: s3, description: d3, duration: 45, date: '2018-01-12')

sp.rows << Row.new(category: c, skill: s, description: d)
sp.rows << Row.new(category: c2, skill: s2, description: d2)
sp.rows << Row.new(category: c3, skill: s3, description: d3)
