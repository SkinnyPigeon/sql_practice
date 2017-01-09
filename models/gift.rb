require( 'pg' )
require_relative( '../db/sql_runner' )
require_relative( './guest' )

class Gift

  attr_reader( :id, :name )

  def initialize( options, runner )
    @id = options[ 'id' ].to_i
    @name = options[ 'name' ]
    @runner = runner
  end

  def save()
    sql = "INSERT INTO gifts (name) VALUES ( '#{ @name }' ) RETURNING *"
    return Gift.map_item( sql, @runner )
  end

  def self.all( runner )
    sql = "SELECT * FROM gifts"
    return Gift.map_items( sql, runner )
  end

  def self.delete_all( runner )
    sql = "DELETE FROM gifts"
    runner.run( sql )
  end

  def guests()
    sql = "SELECT guests.* from guests INNER JOIN guestsgifts ON guestsgifts.guests_id = guests.id WHERE guests_id = #{@id}"
    return Gift.map_items( sql, @runner )
  end

  def self.map_items( sql, runner )
    gifts = runner.run( sql )
    results = gifts.map { |gift| Gift.new( gift, runner ) }
    return results 
  end

  def self.map_item( sql, runner )
    result = Gift.map_items( sql, runner )
    return result.first
  end

end