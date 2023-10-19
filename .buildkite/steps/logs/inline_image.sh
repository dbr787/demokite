#!/bin/bash

link_url=$1

function inline_image {
  printf '\033]1338;url='"$1"';alt='"$2"'\a\n'
}

inline_image $link_url
