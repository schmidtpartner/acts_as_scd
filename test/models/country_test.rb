require 'test_helper'

class ActsAsScdTest < ActiveSupport::TestCase

  fixtures :all

  test "class-method: find_all_by_identity" do
    #################
    ### FIND ANYTHING
    #################
    # should return an Array
    assert_kind_of Array, Country.find_all_by_identity('DEU')

    # should find all countries of an identity ordered by effective_from
    assert_equal [
                     countries(:de1), # DEU
                     countries(:de2), # DEU
                     countries(:de3)  # DEU
                 ], Country.find_all_by_identity('DEU')

    # bang-version of method should behave the same
    assert_kind_of Array, Country.find_all_by_identity!('DEU')
    assert_equal Country.find_all_by_identity('DEU'), Country.find_all_by_identity!('DEU')

    #################
    ### FIND NOTHING
    #################
    # should return an empty array
    assert_equal [], Country.find_all_by_identity('XXX')

    # bang-version should return an Exception
    assert_raises_with_message ActiveRecord::RecordNotFound, 'Could not find any periods.' do
      Country.find_all_by_identity!('XXX')
    end
  end

  test "class-method: at_present" do
    #################
    ### FIND ANYTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.at_present

    # should find the present periods of all countries
    assert_equal [
                     countries(:changedonia_third), # CG
                     countries(:caledonia),         # CL
                     countries(:centuria),          # CTA
                     countries(:de3),               # DEU
                     countries(:uk2),               # GBR
                     countries(:landoftoday),       # LOT
                     countries(:scotland),          # SCO
                 ], Country.at_present.order(:identity).to_a

    # should find the present period of a specific country
    assert_equal countries(:de3), Country.at_present.where(identity: 'DEU').first
    assert_equal countries(:de3), Country.where(identity: 'DEU').at_present.first

    # bang-version of method should behave the same
    assert_kind_of ActiveRecord::Relation, Country.at_present!
    assert_equal Country.at_present.order(:identity).to_a, Country.at_present!.order(:identity).to_a
    assert_equal Country.at_present.where(identity: 'DEU').first, Country.at_present!.where(identity: 'DEU').first
    assert_equal Country.where(identity: 'DEU').at_present.first, Country.where(identity: 'DEU').at_present!.first

    #################
    ### FIND NOTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.where(identity: 'XXX').at_present
    assert_kind_of ActiveRecord::Relation, Country.at_present.where(identity: 'XXX')

    # bang-version should return an Exception
    assert_raises_with_message ActiveRecord::RecordNotFound, 'Could not find any periods.' do
      Country.where(identity: 'XXX').at_present!
    end
    assert_raises_with_message ActiveRecord::RecordNotFound, 'Could not find any periods.' do
      Country.at_present!.where(identity: 'XXX')
    end
  end

  test "class-method: before_date" do
    #################
    ### FIND ANYTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.before_date(Date.today)

    # should find the past periods of all countries
    assert_equal [
                     countries(:changedonia_first),   # CG
                     countries(:de1),                 # DEU
                     countries(:uk1),                 # GBR
                     countries(:ddr),                 # DDR
                     countries(:de2),                 # DEU
                     countries(:changedonia_second),  # CG
                 ], Country.before_date(Date.today).order(:effective_from,:identity).to_a

    # should find the past period of a specific country
    assert_equal countries(:uk1), Country.before_date(Date.today).where(identity: 'GBR').first
    assert_equal countries(:uk1), Country.where(identity: 'GBR').before_date(Date.today).first

    #################
    ### FIND NOTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.where(identity: 'SCO').before_date(Date.today)
    assert_kind_of ActiveRecord::Relation, Country.before_date(Date.today).where(identity: 'SCO')
  end

  test "class-method: after_date" do
    #################
    ### FIND ANYTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.after_date(Date.today)

    # should find the future periods of all countries
    assert_equal [
                     countries(:landin10days), # LOF
                 ], Country.after_date(Date.today).order(:identity).to_a

    # should find the future period of a specific country
    assert_equal countries(:landin10days), Country.after_date(Date.today).where(identity: 'LOF').first
    assert_equal countries(:landin10days), Country.where(identity: 'LOF').after_date(Date.today).first

    #################
    ### FIND NOTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.where(identity: 'DEU').after_date(Date.today)
    assert_kind_of ActiveRecord::Relation, Country.after_date(Date.today).where(identity: 'DEU')
  end

  test "instance-method (association): has_many :cities" do
    #################
    ### FIND ANYTHING
    #################
    # should return an ActiveRecord::Relation
    assert_kind_of ActiveRecord::Relation, Country.where(:identity=>'DEU').first.cities_at_present
    assert_kind_of ActiveRecord::Relation, Country.where(:identity=>'DEU').first.cities_upcoming
  end

  test "class-method: create" do
    ###################
    ### CREATE EXPECTED
    ###################
    # should create a new record with an identity and an unlimited period
    country = Country.create(name: 'Testing 1', code: 'T1')
    assert_kind_of Country, country
    assert_equal country.identity, 'T1'
    assert_equal ActsAsScd::START_OF_TIME, country.effective_from
    assert_equal ActsAsScd::END_OF_TIME, country.effective_to

    #####################
    ### CREATE UNEXPECTED
    #####################
    # should create a new record with an identity and a start-limited period, but not as expected
    country = Country.create(name: 'Testing 2', code: 'T2', effective_from: '2016-01-01')
    assert_kind_of Country, country
    assert_equal country.identity, 'T2'
    assert_not_equal 20160101, country.effective_from # why is that? because values are stored as integer, so the string get's implicitly converted
    assert_equal 2016, country.effective_from         # that is the result of the string-to-integer conversion
    assert_equal ActsAsScd::END_OF_TIME, country.effective_to
    # HEADS UP: always use create_identity, if you want to use the attribute 'effective_from'

    ##################
    ### CREATE NOTHING
    ##################
    # should not create a new record
    country = Country.create(name: 'Testing 3', code: 'T3', effective_from: Date.new(2016,1,1))
    assert_kind_of Country, country
    assert_false country.valid?
    assert_equal 'The given start-date is not valid.', country.errors.messages[:base][0]
    # ensure that the database entry does not exist
    assert_true Country.find_by_identity('T3').nil?
  end

  test "class-method: create_identity" do
    ###################
    ### CREATE EXPECTED
    ###################
    # should create two records, while the second one starts before the first
    # - it should set the end-date of the second record to the start-date of the first
    country1 = Country.create_identity({name: 'later', code: 'T10'}, Date.new(2016,1,1))
    country2 = Country.create_identity({name: 'before', code: 'T10'}, Date.new(2015,1,1))
    assert_kind_of Country, country1
    assert_kind_of Country, country2
    assert_equal country1.identity, 'T10'
    assert_equal country2.identity, 'T10'
    assert_equal 20160101, country1.effective_from
    assert_equal 20150101, country2.effective_from
    assert_equal ActsAsScd::END_OF_TIME, country1.effective_to
    assert_equal 20160101, country2.effective_to

    # should create two records, while the second one starts exactly one day before the first
    # - it should set the end-date of the second record to the start-date of the first
    country1 = Country.create_identity({name: 'later', code: 'T11'}, Date.new(2016,1,2))
    country2 = Country.create_identity({name: 'one_day_before', code: 'T11'}, Date.new(2016,1,1))
    assert_kind_of Country, country1
    assert_kind_of Country, country2
    assert_equal country1.identity, 'T11'
    assert_equal country2.identity, 'T11'
    assert_equal 20160102, country1.effective_from
    assert_equal 20160101, country2.effective_from
    assert_equal ActsAsScd::END_OF_TIME, country1.effective_to
    assert_equal 20160102, country2.effective_to

    # should create two records, while the first has a limited period and the second one starts before the first
    # - it should set the end-date of the second record to the start-date of the first
    country1 = Country.create_identity({name: 'later', code: 'T12'}, Date.new(2016,1,1), Date.new(2017,1,1))
    country2 = Country.create_identity({name: 'before', code: 'T12'}, Date.new(2015,1,1))
    assert_kind_of Country, country1
    assert_kind_of Country, country2
    assert_equal country1.identity, 'T12'
    assert_equal country2.identity, 'T12'
    assert_equal 20160101, country1.effective_from
    assert_equal 20150101, country2.effective_from
    assert_equal 20170101, country1.effective_to
    assert_equal 20160101, country2.effective_to

    ##################
    ### CREATE NOTHING
    ##################
    # should not create two records, when the second one starts after the first
    country1 = Country.create_identity({name: 'before', code: 'T30'}, Date.new(2015,1,1))
    country2 = Country.create_identity({name: 'later', code: 'T30'}, Date.new(2016,1,1))
    assert_kind_of Country, country1
    assert_kind_of Country, country2
    assert_true country1.persisted?
    assert_false country2.persisted?
    assert_equal 'The Country does already exist for the chosen period.', country2.errors.messages[:base][0]

    # should not create two records, when the second one starts exactly at the day of the first
    country1 = Country.create_identity({name: 'equal', code: 'T31'}, Date.new(2015,1,1))
    country2 = Country.create_identity({name: 'equal', code: 'T31'}, Date.new(2015,1,1))
    assert_kind_of Country, country1
    assert_kind_of Country, country2
    assert_true country1.persisted?
    assert_false country2.persisted?
    assert_equal 'The Country does already exist for the chosen period.', country2.errors.messages[:base][0]
  end
end
