# Qualitynode-Knowledgebase
The Docs and stuff

## Automated Frontmatter

The deploy workflow automatically updates markdown frontmatter metadata before building.

When you push changes to markdown files in `content/`, the workflow will:
1. Update frontmatter (`date:` and `author:` fields)
2. Commit the changes with `[meta-master]` tag
3. Build and deploy to Firebase

To skip frontmatter updates on a specific commit, include `[skip ci]` or `[meta-master]` in your commit message.
