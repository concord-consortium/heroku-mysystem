## MySystem Authoring Environment ##

This is a simple environment for authoring, and hosting MySystem activities to [mysystem.concord.org][demo-site]

You can demo the experience over at: [mysystem][demo-site]

The MySystem runtime is maintained at the [concord mysystem git repo][git-site] 


## Buidling and deploying ##

You can update mystem by typing:
    
    bundle exec rake mysys:clean
    bundle exec rake mysys:make

 The task is defined in:

    lib/tasks/mysystem.rake

You can test your local installation by using forman like this:

    bundle exec foreman start

For more infomation about developing with heroku, please read [the heroku docs][heroku-docs]

You can update the server by staging your changes in git, and then running: 

    git push heroku



[heroku-docs]: https://devcenter.heroku.com/articles/procfile
[git-site]: https://github.com/concord-consortium/mysystem_sc
[demo-site]: http://mysys.concord.org
