# Testing AWS In Elixir — Accompanying Code

This repository contains the Elixir code to accompany [this blog
post](https://andrealeopardi.com/posts/testing-aws-in-elixir/).

This is a normal Mix project.

The tests run against [LocalStack](https://localstack.cloud), so you'll need to
start it before running them. In the root of the repository run:

```bash
docker-compose up -d
```

Then, run the tests:

```bash
mix deps.get
mix test
```

By default the tests talk to LocalStack at `http://localhost:4566`. You can
point them elsewhere by setting the `AWS_ENDPOINT_URL` environment variable.
