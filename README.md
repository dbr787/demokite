# demokite

An example [Buildkite](https://buildkite.com/) repository showcasing some of Buildkite's features using [Dynamic Pipelines](https://buildkite.com/docs/pipelines/defining-steps#dynamic-pipelines).

[![Add to Buildkite](https://buildkite.com/button.svg)](https://buildkite.com/new)

## To Do

- Upload artifact and use metadata to point to current artifact
- Change for demo again
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

## Notes

- Setting the padding seemed to truncate the image, sometimes that's what we want...

```
<div class="flex">
  <div class="flex items-start">
    <a href="javascript:void(0)" class="">
      <img
        src="https://f8n-production.s3.amazonaws.com/creators/profile/c8gley51s-nyan-cat-large-gif-gif-mbf1sa.gif"
        alt="A rainbow cat"
        title="meow!"
        width="64"
        class="rounded pr1"
      />
    </a>
  </div>
```

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
