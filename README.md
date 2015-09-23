To reproduce https://github.com/rails/sprockets/issues/127 as we are experiencing it:

How is this setup?

Basically the parent and child apps are the same, but the child app's assets are symlinked in `public/assets` and `tmp/cache/sprockets-4.0`.
You can compile in either app but you can only delete the cache or clobber in the `parent` app.

This is trying to mimic how deploy releases work.

Reproducing the :bug:

1) Bundle both `asset_cache_test_parent` and `asset_cache_test_child` directories

2) cd `asset_cache_test_parent`

3) Run `./assets_script`

This will clobber assets, remove your tmp/cache and then re-compile all assets.

4) Make a change in the `app/assets/stylesheets/all/banana.scss` file. It can be as simple as changing the background color from red to green.

5) Run `bundle exec rake assets:precompile` and you'll see the output that indicates it compiled.

6) cd `../asset_cache_test_child`

7) Make a change in the `app/assets/stylesheets/all/banana.scss` file. Be sure to change it to a color you haven't used before. So if you changed red to green in the parent file change red to blue in the child folder. This is important becasue if the change is exactly the same you won't be reproducing the issue, because the cache hasn't changed from a previous version's cache.

8) Run `bundle exec rake assets:precompile` and you will see that the files did not compile. This is because there is a cache confusion and the child app isn't seeing that it changed versus the parent app. If you flip flop these and change the child first instead of the parent the parent will fail to update.

Fixing the :bug:

If you change the branch to `sprockets-issue` from `https://github.com/eileencodes/sprockets` and re-run this in order of these events you'll see that both child and parent apps compile.
