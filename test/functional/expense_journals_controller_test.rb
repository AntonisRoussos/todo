require 'test_helper'

class ExpenseJournalsControllerTest < ActionController::TestCase
  setup do
    @expense_journal = expense_journals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expense_journals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expense_journal" do
    assert_difference('ExpenseJournal.count') do
      post :create, :expense_journal => @expense_journal.attributes
    end

    assert_redirected_to expense_journal_path(assigns(:expense_journal))
  end

  test "should show expense_journal" do
    get :show, :id => @expense_journal.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @expense_journal.to_param
    assert_response :success
  end

  test "should update expense_journal" do
    put :update, :id => @expense_journal.to_param, :expense_journal => @expense_journal.attributes
    assert_redirected_to expense_journal_path(assigns(:expense_journal))
  end

  test "should destroy expense_journal" do
    assert_difference('ExpenseJournal.count', -1) do
      delete :destroy, :id => @expense_journal.to_param
    end

    assert_redirected_to expense_journals_path
  end
end
