defmodule ExMon.PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  describe "build/4" do
    test "returns the player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "jefferson"
      }

      assert expected_response == Player.build("jefferson", :chute, :soco, :cura)
    end
  end
end
