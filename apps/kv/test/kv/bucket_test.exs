defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  # running before every unit test
  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket} # save PID to EXUnit's map
  end

  test "stores values by key",
    %{bucket: bucket} # get bucket from setup callback
    do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end
