# Configure IEx shell
IEx.configure(
  history_size: -1,
  colors: [ eval_result: [ :cyan, :bright ] ],
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 80
  ]
)

# Put any code here that should be executed when iex is started
