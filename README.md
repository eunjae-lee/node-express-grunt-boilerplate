***THIS REPOSITORY IS NO LONGER MAINTAINED.***

# node-express-grunt-boilerplate

A boilerplate to start a new express project based on CoffeeScript, Grunt build system, Jade Template Engine and bootstrap.

Any suggestions or pull-requests are welcomed!


## Usage

### Preparing
    first, fork this repository!
    git clone git@github.com:{YOUR USERID}/node-express-grunt-boilerplate.git
    cd node-express-grunt-boilerplate
    npm install
    cp config.sample.coffee config.coffee (Modify port number if need)

### Development
    grunt

### Production

#### Starting Server
    grunt production

## Folder Tree
    assets
        vendor
        images
        coffeescripts
        less
    routes
    views

## How to keep updated from this repository
You will fork this repository, and do works on your fork. Meanwhile, we'll do our own work on this repository and sometimes you want to merge our changes into your repository. You can do just following steps:

    # at your repository folder,
    git remote add boilerplate git@github.com:eunjae-lee/node-express-grunt-boilerplate.git
    git fetch boilerplate
    git branch boilerplate boilerplate/master

The steps above will create a branch named "boilerplate" pointing boilerplate repository.
When we update some stuff, you can checkout boilerplate branch and pull the stuff, and merge into your develop, master, etc like following:

    # ex> current branch : master
    git checkout boilerplate
    git pull
    git checkout master
    git merge boilerplate

## More Guide
Basically files under "assets" folder are copied, minified or converted to "public" folder, and node app's static path is set to "public".

* Files under the following folders will be just copied to /public
  * assets/vendor
  * assets/images
    * To compress images, run "grunt imagecomp"
  * assets/javascripts
    * and also uglified to "\*.min.js"
  * assets/stylesheets
    * and also minified to "\*.min.css"
* Files under "assets/coffeescripts" will be converted to "\*.js" and "\*.min.js" at "/public/javascripts"
* Files under "assets/less" will be converted to "\*.css" and "\*.min.css" at "/public/stylesheets"

## Example
    /assets
        /vendor
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

    /public
        /vendor
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
* And the others are just copied into "public".

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
    
### Error: SSL Error: CERT_UNTRUSTED

    npm config set strict-ssl false
    
Check out [this link](http://stackoverflow.com/questions/9626990/receiving-error-error-ssl-error-self-signed-cert-in-chain-while-using-npm).

## License
[MIT](http://opensource.org/licenses/mit-license.html)


## Contributors

* [Chris McKnight](https://github.com/cmckni3)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/eunjae-lee/node-express-grunt-boilerplate/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

