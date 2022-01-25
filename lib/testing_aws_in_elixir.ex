defmodule TestingAwsInElixir do
  @ex_aws_mod Application.compile_env(:testing_aws_in_elixir, [:test_doubles, :ex_aws], ExAws)

  @spec download_file_from_s3!(String.t(), String.t(), keyword) :: :ok
  def download_file_from_s3!(bucket, path, options) do
    dest_path = Keyword.fetch!(options, :to)
    %{body: body} = @ex_aws_mod.request!(ExAws.S3.get_object(bucket, path))
    File.write!(dest_path, body)
    :ok
  end
end
