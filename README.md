# homebrew-utilities

## Notes
To create a new formula start with:
`brew create [URL to Github release tarball]`

This will create a baseline formula with correct release hash digest and
metadata. Move resulting file to utilities formulae repo, clean up, and commit

To update, get the new SHA256 checksum with `shasum -a 256 new-release.tar.gz`

## Sources/Notes
Homebrew Formula cheat sheet by example: https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
Brief "distribute script with Homebrew" walkthrough: https://tech.cars.com/distributing-your-home-grown-tools-to-the-masses-with-homebrew-acb7a62518a8
Apple launchd jobs docs: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html
Homebrew launchd plist files: https://docs.brew.sh/Formula-Cookbook#launchd-plist-files
