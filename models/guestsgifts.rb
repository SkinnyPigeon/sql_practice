require_relative( '../db/sql_runner' )

class GuestsGifts

  def initialize( options, runner )
    @id = options[ 'id' ].to_i
    @guests_id = options[ 'guests_id' ].to_i
    @gifts_id = options[ 'gifts_id' ].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO guestsgifts ( guests_id, gifts_id ) VALUES ( #{@guests_id}, #{@gifts_id} )"
    @runner.run( sql )
  end

  def self.all(runner)
    sql = "SELECT * FROM guestsgifts;"
    guestsgifts = runner.run( sql )
    result = guestsgifts.map { |guestsgift| GuestsGifts.new( guestsgift, runner )}
    return result
  end

  def self.delete_all(runner)
    sql = "DELETE FROM guestsgifts"
    runner.run( sql )
  end

end