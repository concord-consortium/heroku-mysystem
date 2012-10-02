## MySystem Authoring Environment ##

This is a simple environment for authoring, and hosting MySystem activities to [mysystem.concord.org][demo-site]

You can demo the experience over at: [mysystem][demo-site]

The MySystem runtime is maintained at the [concord mysystem git repo][git-site] 


## Buidling and deploying ##

You can update mystem by typing:
    
    bundle exec rake mysys:make

 The task is defined in:

    lib/tasks/mysystem.rake


You can update the server by staging your changes in git, and then running: 

    git push heroku



[git-site]: https://github.com/concord-consortium/mysystem_sc
[demo-site]: http://mysys.concord.org
