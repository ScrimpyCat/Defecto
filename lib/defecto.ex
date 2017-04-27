defmodule Defecto do
    import ExUnit.Assertions
    @moduledoc """
      Convenient chainable assertions for Ecto changesets.
    """

    defmacro __using__(options) do
        quote do
            import Defecto
            @repo unquote(options[:repo])
        end
    end

    @doc """
      Assert a change is valid.
    """
    def assert_change(model, params \\ %{}, changeset_fun \\ :changeset) do
        changeset = apply(model.__struct__, changeset_fun, [model, params])
        assert changeset.valid?
        changeset
    end

    @doc """
      Assert a change is invalid.
    """
    def refute_change(model, params \\ %{}, changeset_fun \\ :changeset) do
        changeset = apply(model.__struct__, changeset_fun, [model, params])
        refute changeset.valid?
        changeset
    end

    @doc """
      Assert a changed field exists.
    """
    def assert_change_field(changeset, field) do
        assert true == Map.has_key?(changeset.changes, field)
        changeset
    end

    @doc """
      Assert a changed field does not exist.
    """
    def refute_change_field(changeset, field) do
        assert false == Map.has_key?(changeset.changes, field)
        changeset
    end

    @doc """
      Assert a changed value is equal to value.
    """
    def assert_change_value(changeset, field, value) do
        assert value == changeset.changes[field]
        changeset
    end

    @doc """
      Assert a changed value is not equal to value.
    """
    def refute_change_value(changeset, field, value) do
        refute value == changeset.changes[field]
        changeset
    end

    @doc """
      Assert an error value is equal to value.
    """
    def assert_error_value(changeset, field, value) do
        assert value == changeset.errors[field]
        changeset
    end

    @doc """
      Assert an error value is not equal to value.
    """
    def refute_error_value(changeset, field, value) do
        refute value == changeset.errors[field]
        changeset
    end

    @doc """
      Assert an insertion produces the expected result and changeset.
    """
    defmacro assert_insert(changeset, result) do
        quote do
            assert_insert(unquote(changeset), unquote(result), @repo)
        end
    end

    @doc """
      Assert an insertion produces the expected result and changeset.
    """
    def assert_insert(changeset, result, repo) do
        assert { ^result, changeset } = repo.insert(changeset)
        changeset
    end

    @doc """
      Assert an insertion does not produce the expected result and changeset.
    """
    defmacro refute_insert(changeset, result) do
        quote do
            refute_insert(unquote(changeset), unquote(result), @repo)
        end
    end

    @doc """
      Assert an insertion does not produce the expected result and changeset.
    """
    def refute_insert(changeset, result, repo) do
        refute { ^result, changeset } = repo.insert(changeset)
        changeset
    end

    @doc """
      Assert an update produces the expected result and changeset.
    """
    defmacro assert_update(changeset, result) do
        quote do
            assert_update(unquote(changeset), unquote(result), @repo)
        end
    end

    @doc """
      Assert an update produces the expected result and changeset.
    """
    def assert_update(changeset, result, repo) do
        assert { ^result, changeset } = repo.update(changeset)
        changeset
    end

    @doc """
      Assert an update does not produce the expected result and changeset.
    """
    defmacro refute_update(changeset, result) do
        quote do
            refute_update(unquote(changeset), unquote(result), @repo)
        end
    end

    @doc """
      Assert an update does not produce the expected result and changeset.
    """
    def refute_update(changeset, result, repo) do
        refute { ^result, changeset } = repo.update(changeset)
        changeset
    end
end
