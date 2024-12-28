# Jujutsu

> Jujutsu—a version control system

## Cheat Sheet

```sh
# push latest change to main
git push origin HEAD:main

# push specific change to main
jj log --no-graph --template 'self.commit_id()' --revision <revision>
```

## Resources

- https://github.com/jj-vcs/jj
