## Releases 

To tag a release and build new Docker images, please use the provided script at
`./release/make-release.sh`:

```
git checkout master
git pull origin master
chmod +x ./release/make-release.sh
./release/make-release.sh <tag>
```

This script does the following:
