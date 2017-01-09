require_relative( 'models/guest.rb' )
require_relative( 'models/gift.rb' )
require_relative( 'models/guestsgifts.rb' )

require( 'pry-byebug' )

runner = SqlRunner.new({ dbname: 'sql_practice', host: 'localhost' })

GuestsGifts.delete_all( runner )
Gift.delete_all( runner )
Guest.delete_all( runner )

guest1 = Guest.new( { "name" => "Euan" }, runner )
guest2 = Guest.new( { "name" => "Dave" }, runner )

g1 = guest1.save()
g2 = guest2.save()

gift1 = Gift.new( { "name" => "plates" }, runner )
p1 = gift1.save()

gift2 = Gift.new( { "name" => "gravy jug" }, runner )
p2 = gift2.save()

gift3 = Gift.new( { "name" => "champagne" }, runner )
p3 = gift3.save()

guestsgifts1 = GuestsGifts.new( { "guests_id" => g1.id, "gifts_id" => p1.id }, runner )
guestsgifts1.save()
guestsgifts2 = GuestsGifts.new( { "guests_id" => g2.id, "gifts_id" => p2.id }, runner )
guestsgifts2.save()
guestsgifts3 = GuestsGifts.new( { "guests_id" => g1.id, "gifts_id" => p3.id }, runner )
guestsgifts3.save()

g1.gifts()

binding.pry
nil