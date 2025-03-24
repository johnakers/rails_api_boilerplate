puts 'Starting Seeds...'

#
Thing.destroy_all

#
FactoryBot.create(:thing)

puts 'Seeds Completed'
