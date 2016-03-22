require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @team = @scoreboard.teams.build(name: "teama", win: 1, loss: 0, tie: 0)
  end
  
  test "should be valid" do
    assert @team.valid?
  end
  
  test 'team name should be present' do
    @team.name = " "
    assert_not @team.valid?
  end
  
  test "win must be zero" do
    @team.win = 0
    assert @team.valid?
  end
  
  test "loss must be zero" do
    @team.loss = 0
    assert @team.valid?
  end
  
  test "tie must be zero" do
    @team.tie = 0
    assert @team.valid?
  end
  
  test "scoreboard id must be present" do
    @team.scoreboard_id = nil
    assert_not @team.valid?
  end
end
