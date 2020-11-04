defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "jefferson"
      }

      assert expected_response == ExMon.create_player("jefferson", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("jefferson", :chute, :soco, :cura)

      messages = capture_io(fn -> assert :ok == ExMon.start_game(player) end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("jefferson", :kick, :punch, :heal)

      capture_io(fn -> ExMon.start_game(player) end)

      # {:ok, player: player, a: 1, b: 2, c: 3}
      :ok
    end

    # , %{b: player} do
    test "when the move is valid, do the move and the computer makes a move" do
      messages = capture_io(fn -> ExMon.make_move(:kick) end)

      assert messages =~ "attacked"
      assert messages =~ "turn"
      assert messages =~ "turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages = capture_io(fn -> ExMon.make_move(:wrong) end)

      assert messages =~ "Invalid move: wrong"
    end

    test "when the game is over, returns game over message" do
      player = ExMon.Game.player() |> Map.put(:life, 0)
      game_state = ExMon.Game.info() |> Map.put(:player, player)

      capture_io(fn -> ExMon.Game.update(game_state) end)

      messages = capture_io(fn -> ExMon.make_move(:kick) end)

      assert messages =~ "The game is over!"
    end
  end
end
