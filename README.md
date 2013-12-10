# node-express-grunt-boilerplate

A boilerplate to start a new express project based on CoffeeScript, Grunt build system, forever runner, Jade Template Engine and bootstrap.

Any suggestions or pull-requests are welcomed!


## Usage

### Preparing
    first, fork this repository!
    git clone git@github.com:{YOUR USERID}/node-express-grunt-boilerplate.git
    cd node-express-grunt-boilerplate
    npm install

### Starting Server
    npm start

### Stopping Server
    npm stop

### Restarting server
    pm2 restart all

### Zero downtime restart
    npm run-script reload

### Check If Server is Running
    ./isRunning.sh

## Folder Tree
    public
        assets
        images
        javascripts
        coffeescripts
        stylesheets
        less
    routes
	views

## More Guide
Basically files under "public" folder are copied, minified or converted to "public_built" folder, and node app's static path is set to "public_built".

* Files under the following folders will be just copied to /public_built
  * public/assets
  * public/images
    * To compress images, run "grunt imagecomp"
  * public/javascripts
    * and also uglified to "\*.min.js"
  * public/stylesheets
    * and also minified to "\*.min.css"
* Files under "public/coffeescripts" will be converted to "\*.js" and "\*.min.js" at "/public_built/javascripts"
* Files under "public/less" will be converted to "\*.css" and "\*.min.css" at "/public_built/stylesheets"

## Example
    /public
        /assets
            /bootstrap-3.0.0
                /css
                	/bootstrap.css
	                /bootstrap.min.css
                /js
                    /bootstrap.js
                    /bootstrap.min.js
        /images
            /bg.png
        /javascripts
            /login
                /login.js
        /coffeescripts
            /login
                /helper.coffee
        /stylesheets
            /login
                /login.css
        /less
            /login
                /test.less

will be converted to

    /public_built
        /assets
            /bootstrap-3.0.0
                /css
                	/bootstrap.css (just copied)
	                /bootstrap.min.css (just copied)
                /js
                    /bootstrap.js (just copied)
                    /bootstrap.min.js (just copied)
        /images
            /bg.png (just copied)
        /javascripts
            /login
                /login.js (just copied)
                /login.min.js (uglified from login.js)
                /helper.js (converted from helper.coffee)
                /helper.min.js (converted from helper.coffee)
        /stylesheets
            /login
                /login.css (just copied)
                /login.min.css (minified from login.css)
                /test.css (converted from test.less)
                /test.min.css (converted from test.less)

And now you can access those static files like following

    http://hostname:port/assets/bootstrap-3.0.0/css/bootstrap.css
    http://hostname:port/images/bg.png
    http://hostname:port/javascripts/login/login.min.js
    http://hostname:port/stylesheets/login/test.min.css

So basically

* "javascripts" and "coffeescripts" are merged into "javascripts".
* "stylesheets" and "less" are merged into "stylesheets".
* And the others are just copied into "public_built".

## Tips & Tricks

### "env" variable at render options
When rendering views, you have to set options obj like

    res.render "index", {
    	title: "Index Page"
		username: "Eunjae Lee"
    }

However, this boilerplate uses a library [render-options-injector](https://github.com/eunjae-lee/render-options-injector) to automatically inject app's environment setting(development, production, ...). So you just can use "env" variable at view templates like following code.

    # index.jade
    if (env == "development")
        script(src='/javascripts/index.js')
    else
        script(src='/javascripts/index.min.js')

And this is how the boilerplate made it work.

    # app.coffee
    injector = require 'render-options-injector'
    ...
    ...
    injector.inject(app, {'env': app.settings.env, 'or': 'other values'})
    ...
    http.createServer(...

## License
[MIT](http://opensource.org/licenses/mit-license.html)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/eunjae-lee/node-express-boilerplate/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

