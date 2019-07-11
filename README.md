# MWA2 Docker Container with LDAP and remote Git sync

This container is currently only built for testing purposes.
Dockerfile updated from macadmins/mwa2

Using mwa2 source, until pull request accepted
```
https://github.com/darshannnn/mwa2.git
```

##### Sync to remote repo:

* For sync to remote repo to work, ssh keys need to be setup and mounted to the container
* Set variable `SYNC_REMOTE_REPO = True` in your `settings.py`
* Git config needs to be configured for git push and pull to work e.g.

```
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
        precomposeunicode = true
[branch "master"]
        remote = origin
        merge = refs/heads/master
[remote "origin"]
        url = git@git_server.com:your_account/munki_repo.git
        fetch = +refs/heads/*:refs/remotes/origin/*

```

# Usage


```
docker run -d --name="munkiwebadmin-ldap-sync" \
  -p 80:8000 \
  -v /path/to/ssh_keys:/root/.ssh \
  -v /path/to/munki_repo:/munki_repo \
  -v /path/to/settings.py:/app/munkiwebadmin/settings.py \
  -e ADMIN_PASS=password \
  darshannnn/mwa2-ldap:latest
```
