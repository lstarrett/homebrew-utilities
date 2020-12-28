# homebrew-utilities

## Notes
To create a new formula start with:
`brew create [URL to Github release tarball]`

This will create a baseline formula with correct release hash digest and
metadata. Move resulting file to utilities formulae repo, clean up, and commit

To update, get the new SHA256 checksum with `shasum -a 256 new-release.tar.gz`
