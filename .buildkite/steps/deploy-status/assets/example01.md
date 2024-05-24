<!-- TODO: Better nested alignment by removing margin next to details chevron '::marker' -->

<p class="h3 pb1">🐥 Buildkite Deployment Status Demo</p>

<p>This annotation can be used to view the status of deployments</p>

<div class="flex h6 regular overflow-auto">
  <table class="">
    <thead>
      <tr>
        <th>Application</th> <th>Environment</th> <th>Deployed Version</th> <th>New Version</th> <th>Deployment Status</th> <th>Last Updated</th>
      </tr>
    </thead>
    <tbody>
      <!--$ROW_1-->
      <!--$ROW_2-->
      <!--$ROW_3-->
    </tbody>
  </table>
</div>

---

<ul class="h6 list-reset">
  <li class="mb1 regular"><a href="$BUILDKITE_BUILD_URL#$BUILDKITE_JOB_ID">:buildkite: View the job in Buildkite ($BUILDKITE_LABEL)</a></li>
  <li class="mb1 regular"><a href="https://argoproj.github.io/" target="_blank">:argocd: View the deployment in ArgoCD</a></li>
</ul>

---

<div class="flex my0 py0 px1 mx1 border-none">
  <img class="rounded px1" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="24" height="32" />
  <img class="rounded px1" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="24" height="32" />
  <img class="rounded px1" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" title="this will be displayed as a tooltip" width="24" height="32" />
</div>

---

<details class="">
  <summary class="h5"><span class="pl1">Expand this section to see font-size options...</span></summary>
  <div class="pl3">
    <p class="h1">Heading 1</p>
    <p class="h2">Heading 2</p>
    <p class="h3">Heading 3</p>
    <p class="h4">Heading 4</p>
    <p class="h5">Heading 5</p>
    <p class="h6">Heading 6</p>
  </div>
</details>
