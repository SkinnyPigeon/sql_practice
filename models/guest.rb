require( 'pg' )
require_relative( '../db/sql_runner' )
require_relative( 'gift' )

class Guest

  attr_reader( :id, :name )

  def initialize( options, runner )
    @id = options[ 'id' ].to_i
    @name = options[ 'name' ]
    @runner = runner
  end

  def save()
    sql = "INSERT INTO guests ( name ) VALUES ( '#{ @name }' ) RETURNING *"
    return Guest.map_item( sql, @runner )
  end

  def self.all( runner )
    sql = "SELECT * FROM guests"
    return Guest.map_items( sql, runner )
  end

  def self.delete_all( runner )
    sql = "DELETE FROM guests"
    runner.run( sql )
  end

  def gifts()
    sql = "SELECT gifts.* from gifts INNER JOIN guestsgifts ON guestsgifts.gifts_id = gifts.id WHERE guests_id = #{@id}"
    return Gift.map_items( sql, @runner )
  end

  def self.map_items( sql, runner )
    guests = runner.run( sql )
    results = guests.map { |guest| Guest.new( guest, runner ) }
    return results 
  end

  def self.map_item( sql, runner )
    result = Guest.map_items( sql, runner )
    return result.first
  end

end