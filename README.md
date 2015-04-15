# WordPress Base
A WordPress alternative to [daft labs base project](https://github.com/daftlabs/base-project)

##usage

- make a git repo (on github or whatever) for your new project
- go to your `code` directory (or your desktop or whatever)
- run the command below using the git url of the repo you just made


```bash
curl https://raw.githubusercontent.com/daftlabs/wordpress-base/master/install.sh | bash -s -- git@github.com:daftlabs/yourproject.git
```

##required configuration
- aws api credentials in `/environments/*`