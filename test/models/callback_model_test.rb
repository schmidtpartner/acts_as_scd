require 'test_helper'

class ActsAsScdTest < ActiveSupport::TestCase

  fixtures :all
  self.use_transactional_fixtures = false

  ### CREATE_ITERATION
  test "should invoke callback by creating a record with create_identity" do
    model = CallbackModel.create_iteration('CLB',{ name: 'Callback Test'},Date.today)
    assert_equal 'Callback Test before_create_iteration the original value was 0000-01-01 after_create_iteration there are 1 antecessors', model.name
  end

  test "should not create an iteration of a record in the past" do
    request_model = CallbackModel.create_iteration('CLB',{ name: 'Callback Test'},Date.yesterday)
    assert_equal 'Callback Test aborted', request_model.name

    assert_equal [ callback_models(:callback_a) ], CallbackModel.find_all_by_identity('CLB')
  end

  test "should not create an iteration of a record in the past and give an error message" do
    # bang-version should return an Exception
    assert_raises_with_message ActiveRecord::RecordInvalid, 'Validation failed: Effective from date is invalid' do
      CallbackModel.create_iteration!('CLB',{ name: 'Callback Test'},Date.yesterday)
    end

    assert_equal [ callback_models(:callback_a) ], CallbackModel.find_all_by_identity('CLB')
  end

  ### TERMINATE_ITERATION
  test "should invoke callback by terminating a record with terminate_identity" do
    model = CallbackModel.terminate_iteration('CLB',Date.today)
    assert_equal 'Callback Test before_terminate_identity the original value was 9999-12-31 after_terminate_identity', model.name
  end

  test "should not terminate a record in the past" do
    request_model = CallbackModel.terminate_iteration('CLB',Date.yesterday)
    assert_equal 'Callback Test aborted', request_model.name

    assert_equal [ callback_models(:callback_a) ], CallbackModel.find_all_by_identity('CLB')
  end

  test "should not terminate a record in the past and give an error message" do
    # bang-version should return an Exception
    assert_raises_with_message ActiveRecord::RecordInvalid, 'Validation failed: Effective to date is invalid' do
      CallbackModel.terminate_iteration!('CLB',Date.yesterday)
    end

    assert_equal [ callback_models(:callback_a) ], CallbackModel.find_all_by_identity('CLB')
  end
end
