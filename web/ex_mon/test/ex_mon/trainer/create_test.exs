defmodule ExMon.Trainer.CreateTest do
  use ExMon.DataCase

  alias ExMon.{Trainer, Repo}
  alias Trainer.Create

  describe "call/1" do
    test "when all params are invalid, creates a trainer" do
      params = %{name: "Jefferson", password: "123456"}

      count_before = Repo.aggregate(Trainer, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{name: "Jefferson"}} = response
      assert count_after > count_before
    end

    test "when there are invalid params, returns the error" do
      params = %{name: "jefferson"}

      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
