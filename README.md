# demokite

An example [Buildkite](https://buildkite.com/) repository showcasing some of Buildkite's features using [Dynamic Pipelines](https://buildkite.com/docs/pipelines/defining-steps#dynamic-pipelines).

[![Add to Buildkite](https://buildkite.com/button.svg)](https://buildkite.com/new)

## To Do

- Have a way to update step yaml definitions before upload
- Update build metadata to allow only choices that haven't already been made
- Re-add dynamic pipelines choice step
- Provide a link to connect to the agent that ran the job?
- Provide a link to stop/pause the agent that ran the job?
- concurrency gates
- Fix indenting
  - Current method wouldn't work with GIFs or hooks, just on the command step
  - Either do it at the bash/OS level
  - Or just indent using the custom echo function
- Include and source a common library of bash functions for all demo steps to use
- Start on annotation demo and examples
  - Include link to step, image, hyperlinks, link to artifact etc.
- Demo for redacted environment variables
