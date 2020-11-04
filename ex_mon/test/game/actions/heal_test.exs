defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Player, Game}
  alias Game.Actions.Heal

  describe "heal_life/1" do
    test "heal life of player" do
      player = Player.build("jefferson", :chute, :soco, :cura)

      capture_io(fn -> ExMon.start_game(player) end)


      messages = capture_io(fn -> assert :ok == Heal.heal_life(:computer) end)

      assert messages =~ "The computer healled itself to"
    end
  end
end
