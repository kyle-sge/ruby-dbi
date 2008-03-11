class TestPostgresTimestamp < DBDConfig.testbase(:postgresql)
	def get_tstamp
        DBI::Timestamp.new(2008, 3, 8, 10, 39, 1, 12300000)
    end

    def test_current_timestamp
        assert @dbh
         # syntax db-specific (e.g., "from dual", "...timestamp()", etc.)
        ts = @dbh.select_one("SELECT CURRENT_TIMESTAMP")[0]
        assert_kind_of DBI::Timestamp, ts
        assert_not_nil ts.fraction
    end

    # Just like the 'general' test, but checking for fractional seconds
    def test_timestamp_fractional
        assert @dbh
        sth = nil
        t = get_tstamp
        assert_nothing_raised do
            sth = @dbh.prepare("insert into timestamp_test (mytimestamp) values (?)")
            sth.execute(t)
            sth.finish
        end

        assert_nothing_raised do
            sth = @dbh.prepare("select * from timestamp_test")
            sth.execute
            row = sth.fetch
            assert_kind_of DBI::Timestamp, row[0]
            assert_equal t.year, row[0].year
            assert_equal t.month, row[0].month
            assert_equal t.day, row[0].day
            assert_equal t.hour, row[0].hour
            assert_equal t.min, row[0].minute
            assert_equal t.sec, row[0].second
            assert_equal t.fraction, row[0].fraction
            assert_not_nil row[0].fraction
            sth.finish
        end
    end

    # Is our DBI::Timestamp equivalent to its canonical string literal
    # form cast appropriately?
    def test_timestamp_from_cast
        assert @dbh
        sql_ts = "SELECT CAST('2008-03-08 10:39:01.012300' AS TIMESTAMP)"

        row = @dbh.select_one(sql_ts)
        assert_not_nil row
        assert_equal 1, row.size

        assert_kind_of DBI::Timestamp, row[0]
        assert_equal row[0], get_tstamp
    end
end
