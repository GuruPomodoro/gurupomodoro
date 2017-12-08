require 'test_helper'

class PomodoroControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get pomodoro_start_url
    assert_response :success
    assert_select "title", "Gurupomodoro | "
  end

  test "should get begin" do
    get pomodoro_begin_url
    assert_response :success
    assert_select "title", "Gurupomodoro | Working"
  end

  test "should get break_start" do
    get pomodoro_break_start_url
    assert_response :success
    assert_select "title", "Gurupomodoro | Break"
  end

  test "should get interrupt" do
    get pomodoro_interrupt_url
    assert_response :success
    assert_select "title", "Gurupomodoro | Interrupt"
  end

  test "should get finished" do
    get pomodoro_finished_url
    assert_response :success
    assert_select "title", "Gurupomodoro | Finished"
  end

end
