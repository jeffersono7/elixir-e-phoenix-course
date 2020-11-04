defmodule ExMon.Game.Actions.AttackTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Player, Game}
  alias Game.Actions.Attack

  describe "attack_opponent/2" do
    player = Player.build("jefferson", :chute, :soco, :cura)

    capture_io(fn -> ExMon.start_game(player) end)

    messages = capture_io(fn -> assert :ok == Attack.attack_opponent(:computer, :move_avg) end)

    assert messages =~ "The Player attacked the computer dealing"
  end
end
