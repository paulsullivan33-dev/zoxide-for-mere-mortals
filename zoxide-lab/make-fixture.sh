#!/bin/sh
# make-fixture.sh — create the guide's practice folder tree under $1 (default $PWD)
set -e
root=${1:-$PWD}
mkdir -p "$root/projects/website" "$root/projects/website-old" "$root/projects/api" \
         "$root/documents/invoices" "$root/documents/letters" \
         "$root/camera/photos" "$root/phone/photos" \
         "$root/garden" "$root/workshop" "$root/attic"
