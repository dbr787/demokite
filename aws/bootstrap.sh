#!/bin/bash
set -exo pipefail

# # create pre-checkout hook
# cat <<EOF >>/etc/buildkite-agent/hooks/pre-checkout
# #!/bin/bash
# set -eo pipefail
# # Created on $(date)
# echo "--- :evergreen_tree: Pre-Checkout Hook"
# env
# echo "pre-checkout hook executed successfully"
# # buildkite-agent annotate "pre-checkout hook executed successfully 🚀"
# EOF

# # update permissions on pre-checkout hook
# sudo chmod +x /etc/buildkite-agent/hooks/pre-checkout
