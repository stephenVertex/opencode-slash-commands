# Check Completed Specs 

In the current project, see if I have a directory called ./specs. 
I would like to enforce the idea that in ./specs/{spec-name}.md has an unimplmemnted spec, and then when it is completed, 
it is moved to ./specs/completed/{spec-name}.md.

This command should check the git logs, the github pull request merges, and the files in ./specs/*.md.
It should then see if we have completed any of those specs. 
If we have, then prompt the user to confirm that spec {spec-name} was completed with {git-commit}, {gh-pr-number}, etc.

Then we can move these spec files to ./specs/completed/{spec-name}.
Once we have done all of this, lets prompt the user to do a git commit and git push.

