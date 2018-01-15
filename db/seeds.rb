# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(username: "Alex")
c = Category.new(name: "Software Development")
u.categories << c
s = Skill.new(name: "Ruby")
u.skills << s
d = Description.new(name: "Mastery Tracker App")
u.descriptions << d
e = Entry.create(category: c, skill: s, description: d, user: u, duration: 60, date: '2018-01-14')

u2 = User.create(username: "Jasmine")
c2 = Category.new(name: "Profession")
u2.categories << c2
s2 = Skill.new(name: "Archaeology")
u2.skills << s2
d2 = Description.new(name: "Edit")
u2.descriptions << d2
e2 = Entry.create(category: c2, skill: s2, description: d2, user: u2, duration: 30, date: '2018-01-13')

c3 = Category.new(name: "Profession")
u.categories << c3
s3 = Skill.new(name: "JavaScript")
u.skills << s3
d3 = Description.new(name: "Exploration")
u.descriptions << d3
e3 = Entry.create(category: c3, skill: s3, description: d3, user: u, duration: 45, date: '2018-01-12')
