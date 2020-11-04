defmodule ExMon.Game.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Status

  describe "print_round_message/1" do
    test "prints the game is started" do
      messages =
        capture_io(fn -> assert :ok == Status.print_round_message(%{status: :started}) end)

      assert messages =~ "The game is started!"
    end

    test "prints it's player turn!" do
      messages =
        capture_io(fn ->
          assert :ok == Status.print_round_message(%{status: :continue, turn: :player})
        end)

      assert messages =~ "It's player turn!"
    end

    test "prints the game over" do
      messages =
        capture_io(fn -> assert :ok == Status.print_round_message(%{status: :game_over}) end)

      assert messages =~ "The game is over!"
    end
  end

  describe "print_wrong_move_message/1" do
    test "prints invalid move" do
      messages = capture_io(fn -> assert :ok == Status.print_wrong_move_message(:wrong_move) end)

      assert messages =~ "Invalid move: wrong_move"
    end
  end

  describe "print_move_message/3" do
    test "print the player attacked the computer" do
      messages = capture_io(fn -> :ok == Status.print_move_message(:computer, :attack, 37) end)

      assert messages =~ "The Player attacked the computer dealing 37 damage"
    end

    test "print the computer attacked the player" do
      messages = capture_io(fn -> :ok == Status.print_move_message(:player, :attack, 37) end)

      assert messages =~ "The Computer attacked the player dealing 37 damage"
    end

    test "print the player heal itself" do
      messages = capture_io(fn -> :ok == Status.print_move_message(:player, :heal, 37) end)

      assert messages =~ "The player healled itself to 37 life points"
    end
  end
end
