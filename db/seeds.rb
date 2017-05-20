# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "FakeUser",
             email: "example@phishingtoolkit.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@phishingtoolkit.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do |n|
  template_name = "FakeTemplate_#{n+1}"
  template_description = Faker::Lorem.sentence(5)
  campaign_name = "FakeCampaign_#{n+1}"
  campaign_smtp_server = "smtp_server_#{n+1}"
  campaign_from = "from_#{n+1}"
  campaign_from_alias = "from_alias_#{n+1}"
  campaign_subject = "subject_#{n+1}"
  campaign_template_id = n+1
  campaign_victims = "victims_#{n+1}"
  users.each { |user| user.templates.create!(name: template_name, 
                                          description: template_description) }
  users.each { |user| user.campaigns.create!(name: campaign_name, 
                                          smtp_server: campaign_smtp_server, 
                                          from: campaign_from, 
                                          from_alias: campaign_from_alias,
                                          subject: campaign_subject,
                                          template_id: user.templates.first.id,
                                          victims: campaign_victims) }
end
