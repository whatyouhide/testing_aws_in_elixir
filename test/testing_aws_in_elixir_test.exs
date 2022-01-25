defmodule TestingAwsInElixirTest do
  use ExUnit.Case

  setup do
    Mox.stub_with(ExAwsMock, ExAws)
    :ok
  end

  test "download_file_from_s3!/3" do
    # Create some random bytes to store in the file.
    contents = :crypto.strong_rand_bytes(100)

    # We set up an on_exit callback to empty and then delete the bucket
    # when the test exit, so that the next test has a clean slate.
    on_exit(fn ->
      "test-bucket"
      |> ExAws.S3.list_objects()
      |> ExAws.stream!()
      |> Enum.each(&ExAws.request!(ExAws.S3.delete_object("test-bucket", &1.key)))

      ExAws.request!(ExAws.S3.delete_bucket("test-bucket"))

      # Also, delete the file we'll create.
      File.rm_rf!("localfile")
    end)

    # Create bucket.
    ExAws.request!(ExAws.S3.put_bucket("test-bucket", "us-west-2"))

    # Upload a file.
    ExAws.request!(ExAws.S3.put_object("test-bucket", "my/random/file", contents))

    # Now, we run our code and assert on its behavior.
    TestingAwsInElixir.download_file_from_s3!("test-bucket", "my/random/file", to: "localfile")
    assert File.read!("localfile") == contents
  end
end
