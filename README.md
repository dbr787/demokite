# demokite

An example [Buildkite](https://buildkite.com/) repository showcasing some of Buildkite's features using [Dynamic Pipelines](https://buildkite.com/docs/pipelines/defining-steps#dynamic-pipelines).

[![Add to Buildkite](https://buildkite.com/button.svg)](https://buildkite.com/new)

## To Do

- Have a way to update step yaml definitions before upload (i.e. to dynamically randomise or assign step attributes)
- Update build metadata to allow only choices that haven't already been made
- Provide a link to connect to the agent that ran the job?
- Provide a link to stop/pause the agent that ran the job?
- concurrency gates
- Fix indenting
  - Current method wouldn't work with GIFs or hooks, just on the command step
  - Either do it at the bash/OS level
  - Or just indent using the custom echo function
- Start on annotation demo and examples
  - Include link to step, image, hyperlinks, link to artifact etc.
- Demo for redacted environment variables

<!-- 
# to use emojis
# :thisisfine: for failing build intentionally
# :perfection: for succeeding build intentionally
# :bash:
# :sadpanda:
# :partyparrot:
# :docker:
# :metal:
# :red_button:
# :terminal:
# :speech_balloon:
# :ghost:
# :writing_hand:
# :index_pointing_at_the_viewer:
# :brain:
# :mage:
# :astronaut:
# :scientist:
# :technologist:
# :teacher:
# :artist:
# :cook:
# :supervillain:
# :superhero:
# :ninja:
# :juggling:
# :shrug:
# :pinched_fingers:
# :nail_care:
-->
