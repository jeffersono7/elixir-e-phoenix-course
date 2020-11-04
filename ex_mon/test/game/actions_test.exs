defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Player, Game}
  alias Game.Actions

  describe "attack/1" do
    setup do
      player = Player.build("jefferson", :chute, :soco, :cura)

      capture_io(fn -> ExMon.start_game(player) end)

      :ok
    end

    test "attack the opponent" do
      messages = capture_io(fn -> assert :ok == Actions.attack(:move_rnd) end)

      assert messages =~ "attacked"
    end
  end

  describe "heal/0" do
    setup do
      player = Player.build("jefferson", :chute, :soco, :cura)

      capture_io(fn -> ExMon.start_game(player) end)

      :ok
    end

    test "heal itself" do
      messages = capture_io(fn -> assert :ok == Actions.heal() end)

      assert messages =~ "healled itself to"
    end
  end

  describe "fetch_move" do
    test "returns the move of player" do
      player = Player.build("jefferson", :punch, :kick, :heal)

      capture_io(fn -> ExMon.start_game(player) end)

      assert {:ok, :move_rnd} == Actions.fetch_move(:punch)
      assert {:ok, :move_avg} == Actions.fetch_move(:kick)
      assert {:ok, :move_heal} == Actions.fetch_move(:heal)
    end

    test "returns error for invalid move" do
      player = Player.build("jefferson", :chute, :soco, :cura)

      capture_io(fn -> ExMon.start_game(player) end)

      assert {:error, :wrong_move} == Actions.fetch_move(:wrong_move)
    end
  end
end
